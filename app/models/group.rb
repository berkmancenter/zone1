class Group < ActiveRecord::Base
  has_and_belongs_to_many :owners, :association_foreign_key => "owner_id", :join_table => "groups_owners", :class_name => "User"
  has_and_belongs_to_many :users, :before_add => :validates_user
  has_many :groups_stored_files
  has_many :stored_files, :through => :groups_stored_files
  has_many :rights, :through => :right_assignments
  has_many :right_assignments, :as => :subject

  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_groups

  validates_presence_of :name  
  validates_uniqueness_of :name

  attr_accessible :name, :assignable_rights, :right_ids

  # Caching related callbacks
  after_update { Group.destroy_viewable_users_cache }
  after_create { Group.destroy_viewable_users_cache }
  after_destroy { Group.destroy_viewable_users_cache }

  def allowed_rights
    self.assignable_rights ? self.rights : []
  end

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

  def self.cached_viewable_users(right)
    Rails.cache.fetch("groups-viewable-users-#{right}") do
      User.find_by_sql("SELECT u.id
        FROM users u
        JOIN groups_users gu ON u.id = gu.user_id
        JOIN groups g ON g.id = gu.group_id
        JOIN right_assignments ra ON ra.subject_id = gu.group_id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'Group'
        AND g.assignable_rights
        AND r.action = '#{right}'").collect { |user| user.id }
    end
  end

  private

  def validates_user(user)
    true #raise ActiveRecord::Rollback if self.users.include? user
  end

  def self.destroy_viewable_users_cache
    Rails.cache.delete_matched(%r{user-rights-*})
    Rails.cache.delete_matched(%r{groups-viewable-users-*})
  end
end
