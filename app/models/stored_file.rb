class StoredFile < ActiveRecord::Base

  include ApplicationHelper

  belongs_to :license
  belongs_to :user
  belongs_to :content_type
  belongs_to :access_level
  belongs_to :batch
  has_many :comments, :dependent => :destroy
  has_many :flaggings, :dependent => :destroy
  has_many :flags, :through => :flaggings
  has_many :groups_stored_files
  has_many :groups, :through => :groups_stored_files
  has_one :disposition, :dependent => :destroy
  belongs_to :mime_type
  has_one :mime_type_category, :through => :mime_type

  delegate :name, :to => :user, :prefix => :contributor
  delegate :name, :to => :license, :prefix => :license, :allow_nil => true

  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :flaggings, :allow_destroy => true
  accepts_nested_attributes_for :disposition
  accepts_nested_attributes_for :groups_stored_files, :allow_destroy => true 

  acts_as_authorization_object

  acts_as_taggable
  acts_as_taggable_on :publication_types, :collections

  after_destroy :increase_available_user_quota

  validates_presence_of :user_id

  GLOBAL_ATTRIBUTES = [:flaggings_attributes, :comments_attributes]

  ALLOW_MANAGE_ATTRIBUTES = [:collection_list, :tag_list, :author, :office,
    :description, :title, :copyright, :allow_tags, :allow_notes,
    :license_id, :publication_type_list, :groups_stored_files_attributes,
    :access_level_id]

  CREATE_ATTRIBUTES = [:user_id, :original_filename, :file] + ALLOW_MANAGE_ATTRIBUTES

  FITS_ATTRIBUTES = [:file_size, :md5, :fits_mime_type]
  
  mount_uploader :file, FileUploader, :mount_on => :file

  searchable(:include => [:tags, :mime_type, :mime_type_category]) do
    integer :id, :stored => true
    text :original_filename, :description
    time :created_at, :trie => true, :stored => true  #trie optimizes the index for ranges
    integer :batch_id, :stored => true
    string :indexed_collection_list, :stored => true, :multiple => true
    string :author, :stored => true
    string :office
    integer :user_id, :references => User
    string :indexed_tag_list, :stored => true, :multiple => true
    integer :flag_ids, :stored => true, :multiple => true, :references => Flag 
    text :copyright
    string :license_name, :stored => true
    integer :license_id, :stored => true, :references => License
    string :title
    integer :file_size, :stored => true
    string :display_name, :stored => true
    string :mime_type_id
    string :mime_type_category_id
  end

  def display_name
    self.title.presence || self.original_filename
  end

  def mime_type_category_id
     #used for faceted search.
     # Delegate didn't really play nice with the nils that are happening before Fits::analyze runs
     self.mime_type.mime_type_category_id if self.mime_type && self.mime_type.mime_type_category
  end

  def fits_mime_type=(hash)
    if hash.keys.include?(:format_name) && hash.keys.include?(:mime_type)
      mime_type = MimeType.find_or_initialize_by_mime_type(hash[:mime_type])

      if mime_type.new_record?
        mime_type.name = hash[:format_name]
        mime_type.extension = File.extname(original_filename)
      end

      self.mime_type = mime_type
    else
      logger.warn "Expected :format_name and :mime_type as keys, but got #{hash.inspect}"
      raise "FITs process not supplying appropriate format data to StoredFile."
    end
  end

  # This determines the intersection of all editable fields in 
  # all selected files in bulk edit. The bulk editable fields
  # are the only fields shown as editable on the bulk edit display.
  def self.bulk_editable_attributes(stored_files, user)
    attrs = stored_files.first.attr_accessible_for({}, user)
    stored_files.each do |stored_file|
      attrs = attrs & stored_file.attr_accessible_for({}, user)
    end
    attrs
  end

  #TODO move into BulkEdit model
  def self.matching_attributes_from(stored_files)
    matching = {}
    attributes_to_match = StoredFile.new.attribute_names + ["tag_list", "collection_list"]

    stored_files.each do |stored_file|
      attributes_to_match.each do |attribute|
        value = stored_file.__send__(attribute)  #must use send in order to call tag_list, collection_list methods

        if matching[attribute].nil?
          matching[attribute] = value
        elsif matching[attribute] != value #on any mis-match
          matching[attribute] = ""
        end
      end
    end
    
    matching
  end

  #TODO move into BulkEdit model
  def self.matching_flags_from(stored_files)
    flags = stored_files.first.flags

    stored_files.each do |stored_file|
      flags = flags & stored_file.flags
    end

    flags    
  end

  #TODO move into BulkEdit model
  def build_bulk_flaggings_for(stored_files, user)
    matching_flags = StoredFile.matching_flags_from(stored_files)
    matching_flags.each do |flag|
      self.flaggings.build(:flag_id => flag.id, :checked => true)     # must explicitly set checked here.  It is the only way
                                                                      # the form will know that this flagging is set 
    end
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

  def find_flagging_id_by_flag_id(flag_id)
    
    id_array = self.flaggings.inject([]) do |array, flagging|
      array << flagging.id if flagging.flag_id.to_s == flag_id
      array
    end

    if id_array.length > 1
      logger.debug "self.flaggings.inspect=" + self.flaggings.inspect
      logger.debug "flagging_attributes.inspect = " + flagging_attributes.inspect
      logger.debug "id_array = " + id_array.inspect
      raise "Should find one flagging.id"

    elsif id_array.length == 1
      return id_array.to_s

    elsif id_array.length == 0
      #it's ok if we find nothing, this means this flag was never set for the stored file
      return nil
    end
  end

  def flaggings_server_side_validation(params, user)
    # This isn't quite as simple as a global attribute to be updated
    # So, we are checking if the user has add and remove rights

    if params.has_key?(:flaggings_attributes)
      Flag.all.each do |flag|
        if params[:flaggings_attributes].has_key?(flag.id.to_s)
          if params[:flaggings_attributes][flag.id.to_s].has_key?(:user_id)
            if !user.can_flag?(flag)
              params[:flaggings_attributes].delete(flag.id.to_s)
            end
          elsif params[:flaggings_attributes][flag.id.to_s][:_destroy] == "1"
            if !user.can_unflag?(flag)
              params[:flaggings_attributes].delete(flag.id.to_s)
            end
          end
        end
      end
    end

    params
  end

  def file_extension_blacklisted?(filename)
    MimeType.blacklisted_extensions.include?(File.extname(filename))
  end

  def custom_save(params, user)

    raise "This type of file is not allowed." if new_record? && file_extension_blacklisted?(params["original_filename"])

    self.accessible = attr_accessible_for(params, user)

    params = flaggings_server_side_validation(params, user)

    prepare_comment_params(params, user)

    if update_attributes(params)

      if params.has_key?(:tag_list)
        update_tags(params[:tag_list], :tags, user)
        params.delete(:tag_list)
      end
  
      if params.has_key?(:collection_list)
        update_tags(params[:collection_list], :collections, user)
        params.delete(:collection_list)
      end
    else
      raise Exception.new(self.errors.full_messages.join(', '))
    end
  end

  # Server side validation updatable attributes
  def attr_accessible_for(params, user)

    valid_attr = GLOBAL_ATTRIBUTES

    if self.new_record?
      valid_attr = valid_attr + CREATE_ATTRIBUTES
    elsif user.can_do_method?(self, "edit_items")
      valid_attr = valid_attr + ALLOW_MANAGE_ATTRIBUTES
    end

    if params.has_key?(:access_level_id) && access_level_id != params[:access_level_id]
      access_level = AccessLevel.find(params[:access_level_id])
      valid_attr << :access_level_id if user.can_set_access_level?(self, access_level)
    end



    valid_attr << :tag_list if allow_tags
    logger.debug "ATTR_ACCESSIBLE_FOR"
    logger.debug valid_attr.uniq.inspect
    valid_attr.uniq
  end

  def indexed_collection_list
    self.owner_tags_on(nil, :collections)
  end

  def collection_list
    #so form value does not have to be manually set
    @collection_list ||= self.anonymous_tag_list(:collections)
  end
  
  def indexed_tag_list
    self.owner_tags_on(nil, :tags)
  end

  def tag_list
    #so form value does not have to be manually set
    @tag_list ||= self.anonymous_tag_list(:tags)
  end

  def file_size=(bytes)
    #when fits updates file_size, update quota
    write_attribute :file_size, bytes
    decrease_available_user_quota bytes
  end

  def decrease_available_user_quota(amount_in_bytes=file_size)
    user.decrease_available_quota!(amount_in_bytes)
  end

  def increase_available_user_quota(amount_in_bytes=file_size)
    user.increase_available_quota!(amount_in_bytes)
  end

  def has_preserved_flag?
    # TODO: Possibly Add caching here
    (self.flags & Flag.preserved).any?
  end

  def has_preserved_or_record_flag?
    # TODO: Possibly Add caching here
    (self.flags & Flag.selected).any?
  end

  def users_via_groups
    # TODO: Add performance improvements here (possibly via low level caching, raw SQL)
    self.groups.collect { |b| b.users }.flatten.uniq
  end

  # User can destroy if a) they have global right to delete items or
  # b) they are the contributor and flag is not preserved or university record
  def can_user_destroy?(user)
    return true if user.can_do_global_method?("delete_items")

    return true if self.user_id == user.id && !self.has_preserved_or_record_flag?

    false
  end

  def anonymous_tag_list(context)
    self.owner_tags_on(nil, context).collect { |t| t.name }.join(', ')
  end

  def update_tags(param, context, user)
    begin
      existing_tags = self.anonymous_tag_list(context).split(", ")
      submitted_tags = param.gsub(/\s+/, '').split(',')

      removed_tags = existing_tags - (existing_tags & submitted_tags)

      # Figure out which tags user is adding, and add
      user_tags = self.owner_tags_on(user, context).collect { |b| b.name }
      updated_tags = user_tags + (submitted_tags - existing_tags) - removed_tags
      user.tag(self, :with => updated_tags.join(","), :on => context)

      # Figure out which global tags user is removing, and remove
      removed_tags.each do |removed_tag|
        # TODO: But acts-as-taggable doesn't give you an easy way to delete another user's tags.
        st = ActiveRecord::Base.connection.execute("DELETE FROM taggings WHERE taggable_id = '#{self.id}' AND context = '#{context.to_s}' AND tag_id = (SELECT id FROM tags WHERE name = '#{removed_tag}')")
      end
    rescue Exception => e
      log_exception e
    end
  end

  # Note: passing flag in hash is not necessary, but is an optimization
  def flag_map(user)
    flag_map = []

    Flag.all.each do |flag|
      flagging = self.flaggings.detect { |f| f.flag_id == flag.id }
      if flagging
        flag_map << { :flagging => flagging, :flag => flag }
      elsif user.can_flag?(flag)
        flag_map << { :flagging => self.flaggings.build(:flag_id => flag.id), :flag => flag }
      end
    end

    flag_map
  end

  # Note: passing group in hash is not necessary, but is an optimization
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

  def self.cached_viewable_users(id)
    Rails.cache.fetch("stored-file-#{id}-viewable-users") do
      stored_file = StoredFile.find(id, :include => :user)

      return User.all.collect { |user| user.id } if stored_file.access_level.name == "open"

      users = [stored_file.user.id] + stored_file.users_via_groups.collect { |user| user.id }

      if stored_file.has_preserved_flag?
        users += Group.cached_viewable_users("view_preserved_flag_content")
        users += Role.cached_viewable_users("view_preserved_flag_content")
        users += User.cached_viewable_users("view_preserved_flag_content")
      end

      users
    end
  end

  private

  def prepare_comment_params(params, user)
    if params[:comments_attributes]
      params[:comments_attributes].delete_if { |key, value| value[:content].empty? }
      params[:comments_attributes].values.each do |comment_hash|
        comment_hash.merge!("user_id" => user.id)
      end
    end
  end
end
