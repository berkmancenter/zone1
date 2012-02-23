class Role < ActiveRecord::Base
  acts_as_authorization_role :join_table_name => :roles_users
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :right_assignments, :as => :subject
  has_many :rights, :through => :right_assignments
  
  attr_accessible :name, :right_ids

  # Caching related callbacks
  after_save :destroy_cache
  after_destroy :destroy_cache

  def self.user_rights
    Rails.cache.fetch("user-rights") do
      Role.find_by_name("user").try(:rights) || []
    end
  end 

  def self.cached_viewable_users(right)
    Rails.cache.fetch("roles-viewable-users-#{right}") do
      self.connection.select_all("SELECT u.id
        FROM users u
        JOIN roles_users gu ON u.id = gu.user_id
        JOIN right_assignments ra ON ra.subject_id = gu.role_id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'Role'
        AND r.action = '#{right}'").collect {|user| user['id'].to_i}
    end
  end


  private

  def destroy_cache
    Rails.cache.delete_matched(%r{user-rights-*})
    Rails.cache.delete("user-rights")
    Rails.cache.delete_matched(%r{roles-viewable-users-*})
  end
end
