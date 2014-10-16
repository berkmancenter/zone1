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

  def self.cached_mime_type_tree
    Rails.cache.fetch("cached_mime_type_tree") do
      self.all.sort_by {|m| m.name}.inject([]) do |array, mtc|
        array << mtc
        mtc.mime_types.sort_by {|m| m.extension}.each do |mt|
          array << mt
        end
        array
      end
    end
  end

  def to_title
    ''
  end

  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.try(:name)
  end

  def self.default
    self.all.detect {|mtc| mtc.name == "Uncategorized"}
  end

  private

  def destroy_cache
    Rails.cache.delete("mime_type_categories")
    Rails.cache.delete("cached_mime_type_tree")
  end

end
