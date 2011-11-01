class StoredFile < ActiveRecord::Base
  belongs_to :license
  belongs_to :user
  belongs_to :content_type
  belongs_to :access_level
  belongs_to :batch
  has_and_belongs_to_many :flags
  has_and_belongs_to_many :groups
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :comments

  acts_as_authorization_object
  before_save :update_file_attributes

  acts_as_taggable
  acts_as_taggable_on :publication_types, :collections
  before_save :update_file_attributes

  attr_accessible :file, :license_id, :collection_name,
    :author, :title, :copyright, :description, :access_level_id,
    :user_id, :content_type_id, :original_filename, :flag_ids, :batch_id,
    :allow_notes, :delete_flag, :office, :tag_list, :publication_type_list,
    :collection_list, :disposition, :group_ids, :comments_attributes

  mount_uploader :file, FileUploader, :mount_on => :file

  searchable(:include => [:tags]) do
	text :original_filename, :description
	date :ingest_date
    date :created_at
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
  end

  def has_preserved_flag?
    preserved_flags = Flag.find_all_by_name(["NOMINATED_FOR_PRESERVATION", "PRESERVED", "SELECTED_FOR_PRESERVATION"])
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

  private

  def update_file_attributes
    if file.present? && file_changed?
      #self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
