class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_users
  acts_as_tagger

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
    :quota_used, :quota_max, :role_ids, :right_ids

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :owned_groups, :class_name => "Group", :join_table => "groups_owners", :foreign_key => "owner_id"
  has_one :sftp_user, :dependent => :destroy
  has_many :batches
  has_many :comments
  has_many :stored_files
  has_many :rights, :through => :right_assignments
  has_many :right_assignments, :as => :subject

  validates_presence_of :name

  validates :quota_max, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true}
  validates :quota_used, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0, :allow_nil => true }

  def quota_used
     #must use self.quota_used in order to call instance method instead of directly accessing database value
    read_attribute(:quota_used) || 0
  end

  def quota_max
    #must use self.quota_max in order to call instance method instead of directly accessing database value
    read_attribute(:quota_max) || default_quota_max
  end

  def default_quota_max
    default = Preference.find_by_name("Default User Upload Quota")
    default.present? ? default.value.to_i : 0
  end

  def quota_max=(amount)
    if amount.to_i != default_quota_max
      write_attribute :quota_max, amount
    else
      write_attribute :quota_max, nil
    end
  end

  def decrease_available_quota!(amount)
    update_attribute(:quota_used, self.quota_used + amount.to_i) 
  end

  def increase_available_quota!(amount)
    if will_quota_be_zeroed?(amount)
      update_attribute(:quota_used, 0)

    else
      update_attribute(:quota_used, self.quota_used - amount.to_i)

    end
  end

  def quota_exceeded?
    self.quota_used >= self.quota_max
  end

  def percent_quota_available
    (self.quota_used.to_f / self.quota_max.to_f)*100
  end

  def quota_available?(amount)
    self.quota_used + amount.to_i <= self.quota_max
  end

  def will_quota_be_zeroed?(amount)
    self.quota_used - amount.to_i <= 0
  end

  def role_rights
    # TODO: Low level caching on this later
    self.roles.collect { |r| r.rights }.flatten.uniq.collect { |r| r.action }
  end

  def all_rights
    # TODO: Low level caching on this later
    [self.roles.collect { |r| r.rights } + self.rights].flatten.uniq.collect { |r| r.action }
  end

  def can_do_global_method?(method)
    self.all_rights.include?(method)
  end

  # stored_file can be an id or it can be a StoredFile
  def can_do_method?(stored_file, method)
    rights = self.all_rights
    return true if rights.include?(method)

    stored_file = stored_file.is_a?(StoredFile) ? stored_file : StoredFile.find(stored_file)
    return true if (stored_file.user == self && rights.include?("#{method}_on_owned"))
    false
  end

  # stored_file can be an id or it can be a StoredFile
  def can_do_group_method?(group, method)
    rights = self.all_rights
    return true if rights.include?(method)

    group = group.is_a?(Group) ? group : Group.find(group)
    return true if (group.owners.include?(self) && rights.include?("#{method}_on_owned"))

    false
  end

  def all_groups
    self.all_rights.include?("edit_groups") ? Group.all : [self.owned_groups, self.groups].flatten.uniq
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
end
