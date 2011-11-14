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

  delegate :name, :to => :user, :prefix => :contributor

  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :flaggings
  accepts_nested_attributes_for :disposition
  accepts_nested_attributes_for :groups_stored_files, :allow_destroy => true 

  acts_as_authorization_object

  acts_as_taggable
  acts_as_taggable_on :publication_types, :collections

  after_create :decrease_available_user_quota
  after_destroy :increase_available_user_quota

  validates_presence_of :user_id


  attr_accessible :file, :license_id, :collection_name,
    :author, :title, :copyright, :description, 
    :user_id, :content_type_id, :original_filename, :batch_id,
    :allow_notes, :delete_flag, :office, :publication_type_list,
    :comments_attributes, :flaggings_attributes, 
    :allow_tags, :collection_list, :disposition, 
    :mime_type, :format_name, :format_version, :file_size, :md5,
    :groups_stored_files_attributes

  mount_uploader :file, FileUploader, :mount_on => :file

  searchable(:include => [:tags]) do
    text :original_filename, :description
    time :created_at, :trie => true  #trie optimizes the index for ranges
    integer :batch_id
    string :collection_list, :stored => true, :multiple => true
    string :author
    string :office
    integer :user_id, :references => User
    string :tag_list, :stored => true, :multiple => true
    integer :flag_ids, :multiple => true, :references => Flag 
    text :copyright
    integer :license_id, :references => License
    string :format_name
    string :title
    integer :file_size
  end

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

  def custom_save(params, current_user)

    attr_accessible_for(params, current_user)

    if update_attributes params

      if params.has_key?(:tag_list)
  
        update_tags(params[:tag_list], :tags, current_user)
        params.delete(:tag_list)
  
      end
  
      if params.has_key?(:collection_list)
  
        update_tags(params[:collection_list], :collections, current_user)
        params.delete(:collection_list)
  
      end
    end
  end


  # Server side validation updatable attributes
  def attr_accessible_for(params, current_user)

    valid_attr = []

    #valid_attr << :disposition_attributes if current_user.can_do_method?(self, "manage_disposition")

    if params.has_key?(:access_level_id) && access_level_id != params[:access_level_id]
      access_level = AccessLevel.find(params[:access_level_id])
      valid_attr << :access_level_id if current_user.can_do_method?(self, "toggle_#{access_level.name}")
    end

    valid_attr << :tag_list if allow_tags || current_user.can_do_method?(self, "edit_items")

    self.accessible = valid_attr
  end

  def collection_list
    #so form value does not have to be manually set
    @collection_list ||= self.anonymous_tag_list(:collections)
  end

  def tag_list
    #so form value does not have to be manually set
    @tag_list ||= self.anonymous_tag_list(:tags)
  end

  def decrease_available_user_quota
    user.decrease_available_quota!(file_size)
  end

  def increase_available_user_quota
    user.increase_available_quota!(file_size)
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

  def can_user_view?(user) 
    return true if user.can_do_method?(self, "view_items") 

    return true if self.access_level.name == "open" 

    return true if user.all_rights.include?("view_preserved_flag_content") && 
      self.has_preserved_flag?
 
    return true if self.users_via_groups.include?(user) && 
      self.access_level.name == "partially_open"

    false
  end

  def can_user_destroy?(user)
    # TODO: Right now, flags trump global right to delete items
    # Possibly, update this so global right to delete item 
    # will give user the right to delete regardless of flags.
    return false if self.has_preserved_or_record_flag?
    return true if user.can_do_method?(self, "delete_items")
    return false
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


  private

  def update_metadata_inline
    metadata = Fits::analyze(self.file.url)

    if metadata.class == Hash and metadata.keys.length > 0
      ::Rails.logger.debug "PHUNK: updating metadata attributes INLINE"
      metadata.each do |name, value|
        # Use send like this instead of update_attributes because update_attributes
        # would require we first call reload in this method (so the before_save
        # conditional works), AND it will make ActiveRecord call save() on this 
        # object a second time.
        self.send("#{name}=", value)
      end
    else
      ::Rails.logger.warn "Warning: stored_file.update_metadata received zero usable data from FITS for id/file #{self.id} - ${self.file.url}"
    end
  end

end
