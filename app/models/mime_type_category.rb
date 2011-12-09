class MimeTypeCategory < ActiveRecord::Base
  has_many :mime_types
  has_many :stored_files, :through => :mime_types

  attr_accessible :name, :image

  validates_presence_of :name

  mount_uploader :image, ImageUploader

  after_update { MimeTypeCategory.destroy_cache }
  after_create { MimeTypeCategory.destroy_cache }
  after_destroy { MimeTypeCategory.destroy_cache }

  def self.all
    Rails.cache.fetch("mime_type_categories") do
      MimeTypeCategory.find(:all, :include => :mime_types)
    end
  end

  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.name
  end

  private

  def self.destroy_cache
    Rails.cache.delete("mime_type_categories")
  end
end
