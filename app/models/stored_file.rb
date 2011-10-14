class StoredFile < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_type
  belongs_to :access_level
  belongs_to :batch
  has_and_belongs_to_many :flags

  searchable(:include => [:tags]) do
	text :original_file_name, :collection_name, :description, :copyright, :license_terms
	string :format_name, :format_version, :mime_type, :md5
	string :tag_list, :stored => true, :multiple => true
	#integer :flag_id, :multiple => true do |file|
	#	file.flags.collect { |flag| flag.name }
	#end
	integer :flag_ids, :multiple => true, :references => Flag 
	date :ingest_date, :retention_plan_date, :retention_plan_action
	integer :file_size
	integer :access_level_id, :multiple => true, :references => AccessLevel
	integer :user_id, :multiple => true, :references => User
	integer :content_type_id, :multiple => true, :references => ContentType
	time :created_at, :updated_at
  end

  acts_as_taggable
  acts_as_taggable_on :publication_types
end
