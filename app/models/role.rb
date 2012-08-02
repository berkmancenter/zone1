class Role < ActiveRecord::Base
  
  # Silly Rails 3.2.0 requirement
  require_association 'right'
  require_association 'right_assignment'

  acts_as_authorization_role :join_table_name => :roles_users
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :right_assignments, :as => :subject
  has_many :rights, :through => :right_assignments

  attr_accessible :name, :right_ids

  after_save :destroy_cache
  after_destroy :destroy_cache

  def self.user_rights
    Rails.cache.fetch("user-rights") do
      Role.find_by_name("user").try(:rights) || []
    end
  end 

  def self.cached_viewable_users(right)
    Rails.cache.fetch("roles-viewable-users-#{right}") do
      self.connection.select_values("SELECT u.id
        FROM users u
        JOIN roles_users gu ON u.id = gu.user_id
        JOIN right_assignments ra ON ra.subject_id = gu.role_id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'Role'
        AND r.action = '#{right}'").map(&:to_i)
    end
  end


  private

  def destroy_cache
    Rails.cache.delete_matched(%r{user-rights-*})
    Rails.cache.delete("user-rights")
    Rails.cache.delete_matched(%r{roles-viewable-users-*})
  end
end
