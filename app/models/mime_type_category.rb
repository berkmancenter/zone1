class MimeTypeCategory < ActiveRecord::Base
  require_association 'mime_type'  # Rails 3.2.0 requirement

  has_many :mime_types
  has_many :stored_files, :through => :mime_types
  attr_accessible :name, :icon

  validates_presence_of :name

  mount_uploader :icon, MimeTypeCategoryIconUploader

  after_save :destroy_cache
  after_destroy :destroy_cache

  def self.all
    Rails.cache.fetch("mime_type_categories") do
      MimeTypeCategory.find(:all, :include => :mime_types)
    end
  end

  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.name
  end

  def self.default
    self.find_by_name("Uncategorized")
  end

  private

  def destroy_cache
    Rails.cache.delete("mime_type_categories")
  end
end
