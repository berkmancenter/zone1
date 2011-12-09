class MimeType < ActiveRecord::Base
  has_many :stored_files
  belongs_to :mime_type_category

  validates_presence_of :name, :mime_type, :extension

  attr_accessible :name, :mime_type, :extension, :blacklist, :mime_type_category_id

  before_create :downcase_extension
  before_create :set_default_category

  after_update { MimeType.destroy_cache }
  after_create { MimeType.destroy_cache }
  after_destroy { MimeType.destroy_cache }

  def self.all
    Rails.cache.fetch("mime_types") do
      MimeType.find(:all)
    end
  end

  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.name
  end

  def self.blacklisted_extensions
    Rails.cache.fetch("file_extension_blacklist") do
      MimeType.where(:blacklist => true).collect{ |mime_type| mime_type.extension }
    end
  end

  def self.file_extension_blacklisted?(filename)
    filename.present? && MimeType.blacklisted_extensions.include?(File.extname(filename).downcase)
  end
  

  def self.blacklisted_message(filename)
    "This type of file (" + File.extname(filename) + ") is not allowed."
  end

  private

  def set_default_category
    self.mime_type_category = MimeTypeCategory.find_or_create_by_name("Uncategorized") unless self.mime_type_category.present?
  end

  def downcase_extension
    self.extension.downcase! if !self.extension.nil?
  end

  def self.destroy_cache
    Rails.cache.delete("file_extension_blacklist") 
    Rails.cache.delete("mime_types")
  end 
end
