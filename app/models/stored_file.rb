class StoredFile < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_type
  belongs_to :access_level
  belongs_to :batch
  has_and_belongs_to_many :flags
  acts_as_authorization_object

  before_save :update_file_attributes
  has_one :license

  acts_as_taggable
  acts_as_taggable_on :publication_types, :collections
  before_save :update_file_attributes

  attr_accessible :file, :license_id, :collection_name,
    :author, :title, :copyright, :description, :access_level_id,
    :user_id, :content_type_id, :original_filename, :flag_ids, :batch_id,
    :allow_notes, :delete_flag, :office, :tag_list, :publication_type_list,
    :collection_list, :disposition

  mount_uploader :file, FileUploader, :mount_on => :file

  searchable(:include => [:tags]) do
	text :original_filename, :collection_name, :description, :copyright
	string :format_name, :format_version, :mime_type, :md5
	string :tag_list, :stored => true, :multiple => true
	integer :flag_ids, :multiple => true, :references => Flag 
	date :ingest_date, :retention_plan_date, :retention_plan_action
	integer :file_size
	integer :access_level_id, :multiple => true, :references => AccessLevel
	integer :license_id, :references => License
	integer :user_id, :multiple => true, :references => User
	integer :content_type_id, :multiple => true, :references => ContentType
	time :created_at, :updated_at
  end

  def has_preserved_flag?
    preserved_flags = Flag.find_all_by_name(["NOMINATED_FOR_PRESERVATION", "PRESERVED", "SELECTED_FOR_PRESERVATION"])
    (self.flags & preserved_flags).any?
  end

  private

  def update_file_attributes
    if file.present? && file_changed?
      #self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end

end
