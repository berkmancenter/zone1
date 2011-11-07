class AccessLevel < ActiveRecord::Base
  has_many :stored_files
  
  validates_uniqueness_of :name

  attr_accessible :name, :label
end
