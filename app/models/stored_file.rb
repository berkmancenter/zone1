class StoredFile < ActiveRecord::Base
  require 'RMagick'
  require 'zone1/fits'

  include ApplicationHelper

  acts_as_paranoid

  belongs_to :license
  belongs_to :user
  belongs_to :access_level
  belongs_to :batch

  has_many :comments, :order => "id", :dependent => :destroy
  has_many :flaggings, :dependent => :destroy
  has_many :flags, :through => :flaggings
  has_many :groups_stored_files, :dependent => :destroy
  has_many :groups, :through => :groups_stored_files
  has_one :disposition, :dependent => :destroy
  belongs_to :mime_type
  has_one :mime_type_category, :through => :mime_type

  delegate :name, :to => :user, :prefix => :contributor
  delegate :name, :to => :license, :prefix => :license, :allow_nil => true
  delegate :name, :to => :access_level, :prefix => :access_level, :allow_nil => true

  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :flaggings, :allow_destroy => true
  accepts_nested_attributes_for :disposition
  accepts_nested_attributes_for :groups_stored_files, :allow_destroy => true 

  acts_as_authorization_object

  acts_as_taggable_on :tags, :collections

  attr_accessor :wants_thumbnail, :defer_quota_update, :defer_search_commit

  before_save :update_file_size
  after_create :register_user_stored_file, :unless => :defer_quota_update
  after_update :paranoid_action_callback, :if => :deleted_at_changed?
  after_update :destroy_cache
  before_destroy :destroy_cache

  # Only unregister this stored file if it was not already soft-deleted
  before_destroy :unregister_user_stored_file, :if => "deleted_at.nil?"

  validates_presence_of :user_id, :access_level_id, :license_id

  mount_uploader :file, FileUploader, :mount_on => :file

  ALWAYS_ACCESSIBLE_ATTRIBUTES = [:flaggings_attributes, :comments_attributes].freeze

  ALLOW_MANAGE_ATTRIBUTES = [:collection_list, :tag_list, :author, :office, :description,
                             :title, :copyright_holder, :allow_tags, :allow_notes,
                             :license_id, :groups_stored_files_attributes, :access_level_id,
                             :original_date, :complete].freeze

  CREATE_ATTRIBUTES = ([:user_id, :original_filename, :file, :batch_id, :defer_quota_update, :source] +
                       ALLOW_MANAGE_ATTRIBUTES).freeze

  FITS_ATTRIBUTES = [:file_size, :md5, :format_version, :mime_type].freeze

  searchable(:include => [:mime_type, :mime_type_category, :flags, :license, :user], :auto_index => false) do
    text :author, :stored => true
    text :contributor_name, :stored => true
    text :copyright_holder, :stored => true
    text :office
    text :display_name, :stored => true
    text :original_filename
    text :description
    text :license_name, :stored => true

    integer :id, :stored => true
    integer :batch_id, :stored => true
    integer :user_id
    integer :flag_ids, :stored => true, :multiple => true
    integer :license_id, :stored => true
    integer :file_size, :stored => true
    integer :mime_type_id
    integer :mime_type_category_id, :stored => true
    integer :access_level_id, :stored => true

    time :original_date, :stored => true, :trie => true
    time :created_at, :stored => true, :trie => true   
    time :deleted_at, :stored => true

    boolean :has_thumbnail, :stored => true
    boolean :complete

    # Original tags and collections. Used for hit *display*
    string :indexed_tag_list, :stored => true, :multiple => true
    string :indexed_collection_list, :stored => true, :multiple => true

    # Case insensitive tags and collections. Used for queries, not display.
    # See lib/zone1/sunspot_search.rb for corresponding facet handling
    string :indexed_tag_list_downcase, :multiple => true do
      self.indexed_tag_list.map {|t| t.name.downcase}
    end
    string :indexed_collection_list_downcase, :multiple => true do
      self.indexed_collection_list.map {|t| t.name.downcase}
    end

    # Used for mime hierarchy reference on search. Minimizes hierarchy lookup.
    string :mime_hierarchy do
      "#{self.mime_type_category_id}-#{self.mime_type_id}"
    end

  end

  # Handle hard destroy via the destroy! method. This must come _after_ the searchable
  # block to ensure that the callbacks leave the search index in correct state
  after_destroy :remove_from_index!, :unless => :defer_search_commit

  def soft_destroy
    # This is from acts_as_paranoid, and DOES trigger update callbacks, surprisingly.
    # Note that one should never call plain old .destroy() on a stored_file instance, as
    # that will hard-destroy all its :dependent => :destroy associations while only 
    # soft-destroying the stored_file. 
    self.delete  
  end

  def hard_destroy
    # Convenience method for hard-destroying a stored file that may or may not already
    # have been soft-destroyed.
    self.deleted_at = nil
    self.destroy!
  end

  def destroy_without_commit!
    # Convenience/encapsulation for hard-destroying a single StoredFile instance
    # without having Sunspot's remove_from_index! automatically called. Used when
    # destroying a bunch of stored files at once. You are responsible for calling
    # Sunspot.commit once you are done destroying all your stored files. Failing to
    # do so may cause ActiveRecord::RecordNotFound errors on the front end.
    self.defer_search_commit = true
    self.hard_destroy
  end

  def mime_type_category_id
    # Used for faceted search and as a convenience method for stored_files_helper#preview
    # Delegate didn't really play nice with the nils that are happening before Fits::analyze runs
    self.mime_type.try :mime_type_category_id
  end

  def display_name
    self.title.presence || self.original_filename
  end

  def indexed_tag_list
    self.owner_tags_on(nil, :tags)
  end

  def indexed_collection_list
    self.owner_tags_on(nil, :collections)
  end

  def flag_set?(flag)
    #must use flaggings here instead of flags, because of bulk edit
    #in bulk edit, flags are not defined, because we're creating a new stored file
    #flaggings are defined for the new bulk_edit stored file
    set_flag_ids = self.flaggings.inject([]) do |array, flagging|
      array << flagging.flag_id if flagging.checked?
      array
    end

    set_flag_ids.include?(flag.id)
  end

  def build_bulk_flaggings_for(stored_files, user)
    matching_flags = BulkEdit.matching_flags_from(stored_files)
    matching_flags.each do |flag|
      # must explicitly set checked here. It is the only way the form will know that this flagging is set 
      self.flaggings.build(:flag_id => flag.id, :checked => true)
    end
  end

  def build_bulk_groups_for(stored_files, user)
    matching_groups = BulkEdit.matching_groups_from(stored_files)
    matching_groups.each do |group|
      #must explicitly set changed here so form will know to check the group 
      self.groups_stored_files.build(:group_id => group.id, :checked => true) 
    end
  end

  def find_flagging_id_by_flag_id(flag_id)
    id_array = self.flaggings.inject([]) do |array, flagging|
      array << flagging.id if flagging.flag_id.to_s == flag_id
      array
    end

    if id_array.length < 2
      # might return nil, which means this flag was never set for the stored file
      return id_array.first
    else
      raise "Something isn't right. StoredFile #{self.id} has #{id_array.count} flaggings. It should have one or none."
    end
  end

  def flaggings_server_side_validation(params, user)
    # This isn't quite as simple as a global attribute to be updated
    # So, we are checking if the user has add and remove rights.
    # This directly modifies the params hash argument, so we return nothing 
    return unless params.has_key?(:flaggings_attributes)

    # shorthand
    attrs = params[:flaggings_attributes]
    
    # Loops through each flag and see if that flag_id shows up in any of the
    # checkbox hashes in attrs. If it does, validate it against can_flag?()
    Flag.all.each do |flag|
      flag_id = flag.id.to_s
      if attrs.any? {|k,v| v['flag_id'] == flag_id}
        attr_key = attrs.select {|k,v| v['flag_id'] == flag_id}.keys.first
        if attrs[attr_key].has_key?(:user_id)
          attrs.delete(attr_key) unless user.can_flag?(flag)
        elsif attrs[attr_key][:_destroy] == "1"
          attrs.delete(attr_key) unless user.can_unflag?(flag)
        end
      end
    end
    params[:flaggings_attributes] = attrs
  end

  def metadata_check?
    # Does this stored_file have any appreciable user-supplied metadata?
    # Note: In order to get accurate results during an update action, this must
    # be called *after* update_attributes such that this method is looking at
    # the most current version of self.

    attr_list = [:flaggings, :collection_list, :tag_list, :author,
                 :office, :description, :title, :copyright_holder, 
                 :allow_tags, :allow_notes, :groups, :original_date]
    attr_list.each do |attr|
      value = self.send(attr)
      return true if !value.blank? && value != [] && value != false
    end
    false
  end

  def custom_save(file_params, user)
    # Note: Calling Sunspot.commit is an exercise left to the user of this model. This
    # enables bulk imports (see remote_file_importer.rb) and updates (bulk_edits_controller)
    # to create or update multiple new StoredFile instances and only call Sunspot.commit 
    # once at the end. (Which is much more efficient.)

    # Operate on a copy of file_params
    params = file_params.dup

    if self.new_record? && MimeType.file_extension_blacklisted?(params[:original_filename])
      raise MimeType.blacklisted_message(params[:original_filename])
    end

    self.accessible = attr_accessible_for(params, user)

    flaggings_server_side_validation(params, user)

    prepare_comment_params(params, user)

    # Use strings instead of symbols so this will work when called via a Resque job, too.
    # Delete these two lists from params because update_attributes can't handle them
    tag_list = params.delete("tag_list")
    collection_list = params.delete("collection_list")
    
    if update_attributes(params)
      update_tags(tag_list, :tags, user) if tag_list
      update_tags(collection_list, :collections, user) if collection_list
      update_column(:complete, metadata_check?)
      self.index
    else
      raise self.errors.full_messages.join(', ')
    end
  end

  # Server side validation updatable attributes
  def attr_accessible_for(params, user)

    valid_attr = ALWAYS_ACCESSIBLE_ATTRIBUTES.dup

    if self.new_record?
      valid_attr = valid_attr + CREATE_ATTRIBUTES
    elsif user.present? && user.can_do_method?(self, "edit_items")
      valid_attr = valid_attr + ALLOW_MANAGE_ATTRIBUTES
    end

    if params.has_key?(:access_level_id) && access_level_id != params[:access_level_id]
      desired_access_level = AccessLevel.find(params[:access_level_id])
      if desired_access_level && user.can_set_access_level?(self, desired_access_level)
        valid_attr << :access_level_id
      end
    end
    valid_attr << :tag_list if self.allow_tags == true && user.present?
    
    valid_attr.uniq
  end

  def collection_list
    #so form value does not have to be manually set
    # Do not name this instance variable @collection_list b/c it conflicts with acts-as-taggable-on internally
    @anonymous_collection_list ||= self.anonymous_tag_list(:collections)
  end
  
  def tag_list
    # Do not name this instance variable @tag_list b/c it conflicts with acts-as-taggable-on internally
    #so form value does not have to be manually set
    @anonymous_tag_list ||= self.anonymous_tag_list(:tags)
  end

  def flag_ids
    self.flags.map(&:id)
  end

  def has_preserved_flag?
    # TODO: Possibly Add caching here
    (self.flags & Flag.preservation).any?
  end

  def has_preserved_or_record_flag?
    # TODO: Possibly Add caching here
    (self.flags & Flag.selected).any?
  end

  def users_via_groups
    if self.access_level != AccessLevel.dark
      # TODO: Add performance improvements here (possibly via low level caching, raw SQL)
      return self.groups.map(&:confirmed_members).flatten.uniq.map(&:id)
    end
    return []
  end

  # User can destroy if a) they have global right to delete items or
  # b) they are the contributor and flag is not preserved or university record
  def can_user_destroy?(user)
    return false if user.nil?

    return true if user.can_do_global_method?("delete_items")

    return true if self.user_id == user.id && !self.has_preserved_or_record_flag?

    false
  end

  def anonymous_tag_list(context)
    self.owner_tags_on(nil, context).map(&:name).join(', ')
  end

  def update_tags(param, context, user)
    begin
      existing_tags = self.anonymous_tag_list(context).split(", ")
      submitted_tags = param.gsub(/\s+/, ' ').split(',').map {|string| string.rstrip.lstrip}

      removed_tags = existing_tags - (existing_tags & submitted_tags)

      # Figure out which tags user is adding, and add
      user_tags = self.owner_tags_on(user, context).map(&:name)
      updated_tags = user_tags + (submitted_tags - existing_tags) - removed_tags
      user.tag(self, :with => updated_tags.join(","), :on => context)

      # Figure out which global tags user is removing, and remove
      removed_tags.each do |removed_tag|
        # Note: acts-as-taggable doesn't give you an easy way to delete another user's tags.
        st = StoredFile.connection.execute("DELETE FROM taggings WHERE taggable_id = '#{self.id}' AND context = '#{context.to_s}' AND tag_id = (SELECT id FROM tags WHERE name = '#{removed_tag}')")
      end
    rescue Exception => e
      log_exception e
    end
  end

  def flag_map(user)
    flag_map = []

    if user.present?
      Flag.all.each do |flag|
        flagging = self.flaggings.detect { |f| f.flag_id == flag.id }
        if flagging
          flag_map << { :flagging => flagging, :flag => flag }
        elsif user.can_flag?(flag)
          flag_map << { :flagging => self.flaggings.build(:flag_id => flag.id), :flag => flag }
        end
      end
    end

    flag_map
  end

  def group_map(user)
    group_map = []

    user.owned_groups.each do |group|
      groups_stored_files_entry = self.groups_stored_files.detect { |g| g.group_id == group.id }
      if groups_stored_files_entry
        group_map << { :groups_stored_files_entry => groups_stored_files_entry, :group => group }
      else 
        group_map << { :groups_stored_files_entry => self.groups_stored_files.build(:group_id => group.id), :group => group }
      end
    end
 
    group_map
  end

  def post_process
    fits_ok = set_fits_attributes
    thumbnail_ok = generate_thumbnail
    if fits_ok || thumbnail_ok
      self.save! 
      self.index
    end
  end

  def file_url(*args)
    # Overridden version of CarrierWave::Mount.#{mounted_on}_url to do special handling for :thumbnail
    file_path = self.file.url(*args)
    return args.first == :thumbnail ? thumbnail_path(file_path) : file_path
  end

  def set_fits_attributes
    # Note: Does NOT save changes to database
    # Returns: Boolean based on whether or not FITS returned usable metadata
    begin
      metadata = Fits::analyze(self.file_url)
      if !(metadata.class == Hash && metadata.keys.length > 0)
        ::Rails.logger.warn "Got un-usable metadata from FITS: #{metadata.inspect}"
        return false
      end

      self.accessible = FITS_ATTRIBUTES
      updated_attrs = metadata.slice(*FITS_ATTRIBUTES)
      updated_attrs[:mime_type] = MimeType.new_from_attributes(metadata)
      updated_attrs.delete_if {|attr, value| value.blank?}
      self.attributes = updated_attrs

      return true
    rescue Exception => e
      log_exception e
    end
    return false
  end

  def generate_thumbnail
    @wants_thumbnail = true
    self.file.recreate_versions! rescue cleanup_failed_thumbnail
    @wants_thumbnail = false

    if self.file.has_thumbnail?
      # Don't use self.file_url(:thumbnail) in this method because we override it
      current_thumbnail_path = self.file.thumbnail.url

      # If the current thumbnail is not a jpg, replace it with one we create
      if current_thumbnail_path !~ /\.jpg$/i
        jpg_path = thumbnail_path(current_thumbnail_path)
        im = Magick::ImageList.new(current_thumbnail_path).first
        im.write(jpg_path)

        # If it was just created correctly, delete the previous, non-jpg one
        if File.exist? jpg_path
          self.has_thumbnail = true
          File.delete current_thumbnail_path
        end
      else
        self.has_thumbnail = true
      end
    end

    self.has_thumbnail
  end

  def self.cached_viewable_users(id)
    Rails.cache.fetch("stored-file-#{id}-viewable-users") do
      stored_file = StoredFile.find(id)

      # This assumes that if the stored file access level is open
      # no global user array is generated.

      users = [stored_file.user.id] + stored_file.users_via_groups

      if stored_file.has_preserved_flag?
        users += User.users_with_right("view_preserved_flag_content")
      end

      users.uniq
    end
  end


  private

  def paranoid_action_callback
    # Handle our soft_destroy and acts_as_paranoid's restore! methods
    # Note: Caching is handled by other more general callbacks
    if deleted?
      # soft-destroyed
      remove_from_index!
      unregister_user_stored_file
    else
      # restored
      index!
      register_user_stored_file
    end
  end

  def unregister_user_stored_file
    user.increase_available_quota!(file_size)
  end

  def register_user_stored_file
    user.decrease_available_quota!(file_size)
  end

  def cleanup_failed_thumbnail
    # Delete cached files that have been orphaned in their cache directory.
    # Note that cache_dir is always going to be specific to this stored_file
    # instance, but we are still explicit about what files we try to delete,
    # just to be on the safe side. (It should never matter, really.)
    return if self.file.cache_name.nil? || self.file.cache_dir.nil?

    cache_dir = File.dirname(File.expand_path(self.file.cache_name, self.file.cache_dir))
    base_name = File.basename(self.file.cache_name)
    cache_files = [
             File.expand_path(base_name, cache_dir),
             File.expand_path('thumbnail_' + base_name, cache_dir)
            ]
    cache_files.each {|f| File.delete(f) rescue nil}
    Dir.rmdir cache_dir    
  end

  def thumbnail_path(file_path)
    file_path.sub( /(\.+[^\.]*|)$/, '.jpg' ) if file_path.present?
  end

  def update_file_size
    if self.file_size.nil? && file.present? && file_changed?
      self.file_size = file.file.size
    end
  end

  def prepare_comment_params(params, user)
    if params[:comments_attributes]
      params[:comments_attributes].delete_if { |key, value| value[:content].empty? }
      params[:comments_attributes].values.each do |comment_hash|
        comment_hash.merge!(:user_id => user.id)
      end
    end
  end

  def destroy_cache
    raise Exception.new("no self.id found in destroy_cache") unless self.id.present?
    Rails.cache.delete("tag-list")
    Rails.cache.delete("stored-file-#{self.id}-viewable-users")
  end


end
