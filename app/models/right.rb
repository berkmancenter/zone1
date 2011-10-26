class Right < ActiveRecord::Base
  validates_presence_of :method
  validates_uniqueness_of :description

  has_many :right_assignments
end
