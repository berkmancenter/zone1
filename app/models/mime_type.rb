class MimeType < ActiveRecord::Base
  has_many :stored_files
  belongs_to :mime_type_category

  validates_presence_of :name, :mime_type

  attr_accessible :name, :mime_type, :extension, :blacklist, :mime_type_category_id

  before_create :downcase_extension
  before_create :set_default_category

  after_save :destroy_cache
  after_destroy :destroy_cache

  def self.all
    Rails.cache.fetch("mime_types") do
      MimeType.find(:all)
    end
  end

  def to_title
    "#{self.name} (#{self.mime_type})"
  end
  
  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.extension rescue 'Unknown'
  end

  def self.blacklisted_extensions
    Rails.cache.fetch("extension_blacklist") do
      MimeType.where(:blacklist => true).map(&:extension)
    end
  end

  def self.extension_blacklisted?(filename='')
    # Note that '' (empty string) is a valid MimeType record and is blacklist-able
    MimeType.blacklisted_extensions.include?(File.extname(filename).downcase) unless filename.nil?
  end
  
  def self.blacklisted_message(filename)
    "This type of file (" + File.extname(filename) + ") is not allowed."
  end

  def self.new_from_attributes(attr_hash)
    # Note: Expected behavior is to NOT save the new MimeType instance instantiated here
    file_extension = attr_hash[:file_extension] || ''
    mime_type = MimeType.find_or_initialize_by_extension(file_extension.downcase)

    if mime_type.new_record?
      mime_type.name = attr_hash[:format_name]
      mime_type.mime_type = attr_hash[:mime_type]  #text/plain, etc
      human_name = attr_hash[:mime_type].split("/").first.capitalize
      # If this find returns nil, set_default_category will handle it in a callback
      mime_type.mime_type_category = MimeTypeCategory.find_by_name(human_name)
    end

    mime_type
  end

  private

  def set_default_category
    c = MimeTypeCategory.find_by_name(mime_type.split("/").first.capitalize)
    self.mime_type_category ||= c || MimeTypeCategory.default
  end

  def downcase_extension
    self.extension.try(:downcase!)
  end

  def destroy_cache
    Rails.cache.delete("extension_blacklist") 
    Rails.cache.delete("mime_types")
    Rails.cache.delete("cached_mime_type_tree")
    # If this mime_type got moved to a diferent mime_type_category, delete that cache too
    Rails.cache.delete("mime_type_categories") if mime_type_category_id_changed?
  end 
end
