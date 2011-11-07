class Role < ActiveRecord::Base
  acts_as_authorization_role :join_table_name => :roles_users
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :right_assignments, :as => :subject
  has_many :rights, :through => :right_assignments
end
