class MimeType < ActiveRecord::Base
  has_many :stored_files
  belongs_to :mime_type_category

  validates_presence_of :name, :mime_type, :extension

  attr_accessible :name, :mime_type, :extension, :blacklist

  after_initialize :set_default_category

  def self.blacklisted_extensions
    # TODO: Add cache expiration / sweepers
    Rails.cache.fetch("file_extension_blacklist") do
      MimeType.where(:blacklist => true).collect{ |mime_type| mime_type.extension }
    end
  end

  private
  def set_default_category
    self.mime_type_category = MimeTypeCategory.find_or_create_by_name("Uncategorized")
  end
end
