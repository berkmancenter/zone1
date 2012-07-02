class User < ActiveRecord::Base

  require_association 'right_assignment'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_users
  acts_as_tagger

  after_save :destroy_cache
  after_destroy :destroy_cache

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
    :quota_used, :quota_max, :role_ids, :right_ids

  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships, :source => :group

  has_and_belongs_to_many :roles

  has_many :sftp_users, :dependent => :destroy
  has_many :batches
  has_many :comments
  has_many :stored_files
  has_many :rights, :through => :right_assignments
  has_many :right_assignments, :as => :subject

  validates_presence_of :name

  validates :quota_max, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true}
  validates :quota_used, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true}

  def quota_used
    #must use self.quota_used in order to call instance method instead of directly accessing database value
    # TODO: do we need this, especially since we have added a default value of zero to the DB?
    read_attribute(:quota_used) || 0
  end

  def quota_max
    #must use self.quota_max in order to call instance method instead of directly accessing database value
    read_attribute(:quota_max) || default_quota_max
  end

  def default_quota_max
    Preference.default_user_upload_quota.to_i rescue 0
  end

  def quota_max=(amount)
    write_attribute :quota_max, (amount.to_i != default_quota_max ? amount : nil)
  end

  def decrease_available_quota!(amount)
    return increment!(:quota_used, amount.to_i)
  end

  def increase_available_quota!(amount)
    new_quota_used = (self.quota_used - amount.to_i > 0) ? self.quota_used - amount.to_i : 0
    update_attribute(:quota_used, new_quota_used)
  end

  def percent_quota_available
    (self.quota_used.to_f / self.quota_max.to_f)*100
  end

  def role_rights
    # TODO: Low level caching on this later
    self.roles.collect { |r| r.rights }.flatten.uniq.collect { |r| r.action }
  end

  def group_rights
    self.groups.collect { |g| g.allowed_rights }.flatten.uniq.collect { |r| r.action }
  end

  def all_rights
    # A user's rights includes all rights assigned through
    # groups, roles, and directly to rights, through the 
    # polymorphic right_assignments table
    Rails.cache.fetch("user-rights-#{self.id}") do
      [
       Role.user_rights +
       self.rights +
       self.groups.map(&:allowed_rights) +
       self.roles.map(&:rights)
      ].flatten.uniq.map(&:action)
    end
  end

  def can_do_global_method?(method)
    self.all_rights.include?(method)
  end

  def can_do_method?(stored_file, method)
    # stored_file can be an id or a StoredFile instance
    return true if can_do_global_method?(method)

    if stored_file.is_a?(StoredFile)
      user_id = stored_file.user_id
    else
      # We use select_all to avoid object instantiation
      user_id = self.connection.select_all(
        "SELECT user_id FROM stored_files WHERE id = #{stored_file} LIMIT 1"
      ).first['user_id'].to_i
    end

    return (user_id == self.id && can_do_global_method?("#{method}_on_owned"))
  end

  def can_do_group_method?(group, method)
    # group can be an id or a Group instance
    #TODO: give this the same select all treatment that can_do_method? got
    return true if can_do_global_method?(method)

    group = group.is_a?(Group) ? group : Group.find(group)
    return (group.owners.include?(self) && can_do_global_method?("#{method}_on_owned"))
  end

  def owned_groups
    memberships.owner.includes(:group).inject([]) {|array, m| array << m.group; array}
  end

  def all_groups
    can_do_global_method?("edit_groups") ? Group.all : [self.owned_groups, self.groups].flatten.uniq
  end

  def can_flag?(flag)
    self.can_do_global_method?("add_#{flag.name.downcase}")
  end

  def can_unflag?(flag)
    self.can_do_global_method?("remove_#{flag.name.downcase}")
  end

  def can_set_access_level?(stored_file, access_level)
    self.can_do_method?(stored_file, "toggle_#{access_level.name}") 
  end

  def self.users_with_right(right)
    users = Group.cached_viewable_users(right)
    users += Role.cached_viewable_users(right)
    users += User.cached_viewable_users(right)
    users
  end

  def self.cached_viewable_users(right)
    Rails.cache.fetch("users-viewable-users-#{right}") do
      self.connection.select_all("SELECT u.id
        FROM users u
        JOIN right_assignments ra ON ra.subject_id = u.id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'User'
        AND r.action = '#{right}'").collect {|user| user['id'].to_i}
    end
  end

  # Note: This assumes that open files are checked prior
  # to this call (ie it ignores access level)
  def can_view_cached?(stored_file_id)
    users = StoredFile.cached_viewable_users(stored_file_id)
    users += User.users_with_right("view_items")
    users.include?(self.id)
  end

  def self.all
    Rails.cache.fetch("users") do
      User.find(:all)
    end
  end

  
  private

  # Note: When a user is added to a group, role, or assigned a right,
  # all of these caches need to be invalidated.
  def destroy_cache
    Rails.cache.delete("user-rights-#{self.id}")
    Rails.cache.delete("users")
    Rails.cache.delete_matched(%r{users-viewable-users-*})
    Rails.cache.delete_matched(%r{roles-viewable-users-*})
    Rails.cache.delete_matched(%r{groups-viewable-users-*})
  end
end
