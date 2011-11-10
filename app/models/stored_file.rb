class StoredFile < ActiveRecord::Base
  belongs_to :license
  belongs_to :user
  belongs_to :content_type
  belongs_to :access_level
  belongs_to :batch
  has_many :comments, :dependent => :destroy
  has_many :flaggings, :dependent => :destroy
  has_many :flags, :through => :flaggings
  has_and_belongs_to_many :groups
  has_one :disposition, :dependent => :destroy

  # TODO: Maybe implement this later based on design
  #accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :flaggings
  accepts_nested_attributes_for :disposition

  acts_as_authorization_object

  acts_as_taggable
  acts_as_taggable_on :publication_types, :collections

  after_create :decrease_available_user_quota
  after_destroy :increase_available_user_quota

  validates_presence_of :user_id


  attr_accessible :file, :license_id, :collection_name,
    :author, :title, :copyright, :description, :access_level_id,
    :user_id, :content_type_id, :original_filename, :batch_id,
    :allow_notes, :delete_flag, :office, :tag_list, :publication_type_list,
    :comments_attributes, :flaggings_attributes, :disposition_attributes,
    :allow_tags, :collection_list, :disposition, :group_ids, 
    :mime_type, :format_name, :format_version, :file_size, :md5

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

  def decrease_available_user_quota
    user.decrease_available_quota!(file_size)
  end

  def increase_available_user_quota
    user.increase_available_quota!(file_size)
  end

  def has_preserved_flag?
    # TODO: Add caching here
    preserved_flags = Flag.find_all_by_name(["NOMINATED_FOR_PRESERVATION", "PRESERVED", "SELECTED_FOR_PRESERVATION"])
    (self.flags & preserved_flags).any?
  end

  def has_preserved_or_record_flag?
    # TODO: Add caching here
    preserved_flags = Flag.find_all_by_name(["SELECTED_FOR_PRESERVATION", "UNIVERSITY_RECORD"])
    (self.flags & preserved_flags).any?
  end

  def users_via_groups
    # TODO: Add performance improvements here (possibly via low level caching, raw SQL)
    self.groups.collect { |b| b.users }.flatten.uniq
  end

  def can_user_view?(user) 
    return true if user.can_do_method?(self, "view_items") 

    return true if self.access_level.name == "open" 

    return true if user.list_rights.include?("view_preserved_flag_content") && 
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
    self.send(context).collect { |t| t.name }.join(", ")
  end

  def update_tags(param, context, user)
    begin
      existing_tags = self.anonymous_tag_list(context).split(", ")
      submitted_tags = param.gsub(/\s+/, '').split(',')

      # Figure out which tags user is adding, and add
      user_tags = self.owner_tags_on(user, context).collect { |b| b.name }
      updated_tags = user_tags + (submitted_tags - existing_tags)
      user.tag(self, :with => updated_tags.join(","), :on => context)

      # Figure out which global tags user is removing, and remove
      removed_tags = existing_tags - (existing_tags & submitted_tags)
      removed_tags.each do |removed_tag|
        # TODO: If possible, avoid raw SQL here. But acts-as-taggable doesn't give you an easy way to delete owned tags.
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
