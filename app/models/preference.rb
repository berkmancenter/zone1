class Preference < ActiveRecord::Base
  validates_presence_of :name, :value
  attr_accessible :name, :value
end
