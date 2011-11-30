class Role < ActiveRecord::Base
  acts_as_authorization_role :join_table_name => :roles_users
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :right_assignments, :as => :subject
  has_many :rights, :through => :right_assignments
  
  attr_accessible :name, :right_ids

  # Caching related callbacks
  after_update { Group.destroy_viewable_users_cache }
  after_create { Group.destroy_viewable_users_cache }
  after_destroy { Group.destroy_viewable_users_cache }

  def self.cached_viewable_users(right)
    Rails.cache.fetch("roles-viewable-users-#{right}") do
      User.find_by_sql("SELECT u.id
        FROM users u
        JOIN roles_users gu ON u.id = gu.user_id
        JOIN right_assignments ra ON ra.subject_id = gu.role_id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'Role'
        AND r.action = '#{right}'").collect { |user| user.id }
    end
  end

  private

  def self.destroy_viewable_users_cache
    Rails.cache.delete_matched(%r{roles-viewable-users-*})
  end
end
