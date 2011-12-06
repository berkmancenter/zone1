class MimeTypeCategory < ActiveRecord::Base
  has_many :mime_types
  has_many :stored_files, :through => :mime_types

  attr_accessible :name

  validates_presence_of :name
end
