class Flag < ActiveRecord::Base
  validates_presence_of :name, :label
  validates_uniqueness_of :name
end
