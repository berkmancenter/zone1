class Group < ActiveRecord::Base
  has_many :statuses
  has_and_belongs_to_many :owners, :association_foreign_key => "owner_id", :join_table => "groups_owners", :class_name => "User"
  has_and_belongs_to_many :users, :before_add => :validates_user

  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_groups
  
  validates_uniqueness_of :name

  private
    def validates_user(user)
      raise ActiveRecord::Rollback if self.users.include? user
    end
end
