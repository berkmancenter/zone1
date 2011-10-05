class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_groups
  
  validates_uniqueness_of :name
end
