class Flag < ActiveRecord::Base
  has_and_belongs_to_many :stored_files
   
  validates_uniqueness_of :name
end
