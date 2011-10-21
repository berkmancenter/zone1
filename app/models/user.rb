class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_users

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :groups
  has_many :stored_files
  has_many :batches
  has_one :sftp_users, :dependent => :destroy
end
