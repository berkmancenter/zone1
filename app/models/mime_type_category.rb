class MimeTypeCategory < ActiveRecord::Base
  has_many :mime_types
  has_many :stored_files, :through => :mime_types

  attr_accessible :name, :image

  validates_presence_of :name

  mount_uploader :image, ImageUploader
end
