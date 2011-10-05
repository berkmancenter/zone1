class StoredFile < ActiveRecord::Base
  belongs_to :user
  belongs_to :content_type
  belongs_to :access_level
  belongs_to :batch
  has_and_belongs_to_many :flags

  acts_as_taggable
end
