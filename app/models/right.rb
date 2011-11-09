class Right < ActiveRecord::Base
  validates_presence_of :action

  has_many :right_assignments
  has_many :roles,
    :through => :right_assignments,
    :source => :subject,
    :source_type => "Role"

  attr_accessible :action, :description, :role_ids
end
