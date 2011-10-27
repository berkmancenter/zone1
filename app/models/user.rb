class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_users

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_and_belongs_to_many :roles
  has_many :stored_files
  has_many :batches
  has_one :sftp_users, :dependent => :destroy
  has_many :right_assignments, :as => :subject
  has_many :rights, :through => :right_assignments
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :owned_groups, :class_name => "Group", :join_table => "groups_owners", :foreign_key => "owner_id"

  def list_rights
    # TODO: Low level caching on this later
    [self.roles.collect { |r| r.rights } + self.rights].flatten.uniq.collect { |r| r.method }
  end

  def can_do_global_method?(method)
    return true if self.list_rights.include?(method)
    false
  end

  # stored_file can be an id or it can be a StoredFile
  def can_do_method?(stored_file, method)
    rights = self.list_rights
    return true if rights.include?(method)

    stored_file = stored_file.is_a?(StoredFile) ? stored_file : StoredFile.find(stored_file)
    return true if (stored_file.user == self && rights.include?("#{method}_to_own_content"))
    false
  end
end
