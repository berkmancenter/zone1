class Group < ActiveRecord::Base
  has_and_belongs_to_many :owners, :association_foreign_key => "owner_id", :join_table => "groups_owners", :class_name => "User"
  has_and_belongs_to_many :users, :before_add => :validates_user

  has_many :groups_stored_files
  has_many :stored_files, :through => :groups_stored_files

  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_groups
  
  validates_uniqueness_of :name

  attr_accessible :name

  def members
    members = {}
    self.users.each do |user|
      members[user.email] = { :user => user, :owner => false }
    end
    self.owners.each do |user|
      members[user.email] = { :user => user, :owner => true }
    end
    members
  end

  private
  def validates_user(user)
    true #raise ActiveRecord::Rollback if self.users.include? user
  end
end
