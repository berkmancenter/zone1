class Group < ActiveRecord::Base

  has_many :memberships, :include => :user
  has_many :groups_stored_files, :dependent => :destroy
  has_many :stored_files, :through => :groups_stored_files
  has_many :rights, :through => :right_assignments
  has_many :right_assignments, :as => :subject

  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_groups

  validates_presence_of :name  
  validates_uniqueness_of :name

  # Can't create group if it won't pass the validation
  # so only validate owner is set on update
  validate :group_has_one_owner, :on => :update

  attr_accessible :name, :assignable_rights, :right_ids, :memberships_attributes

  accepts_nested_attributes_for :memberships, :allow_destroy => true

  # Caching related callbacks
  after_save :destroy_viewable_users_cache
  after_destroy :destroy_viewable_users_cache

  # Instead of using the typical :dependent => :destroy option
  # We create our own callback to clean up memberships
  # while still being able to enforce :group_has_one_owner constraint
  before_destroy :delete_memberships

  def allowed_rights
    self.assignable_rights ? self.rights : []
  end

  def self.cached_viewable_users(right)
    Rails.cache.fetch("groups-viewable-users-#{right}") do
      self.connection.select_all("SELECT u.id
        FROM users u
        JOIN memberships m ON u.id = m.user_id
        JOIN groups g ON g.id = m.group_id
        JOIN right_assignments ra ON ra.subject_id = m.group_id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'Group'
        AND g.assignable_rights
        AND m.joined_at IS NOT NULL
        AND r.action = '#{right}'").collect {|user| user['id'].to_i}
    end
  end

  def invite_users_by_email(user_emails, invited_by_user=nil)
    invited_by = invited_by_user.try(:id)
    user_emails.each do |email|
      user = User.find_by_email(email)
      if user
        Membership.invite_users_to_groups([user], [self], :invited_by => invited_by)
      else
        raise "Could not find existing user #{email}"
      end
    end
  end

  # Convenience methods which scope according to their name. 
  # All these methods return an array of users. 
  # The has_many :memberships includes users so
  # the SQL for this collection is efficent and NOT N+1
  def members
    memberships.collect { |m| m.user }
  end
  
  def invited_members
    memberships.invited.collect{ |m| m.user }
  end

  def confirmed_members
    memberships.confirmed.collect { |m| m.user }
  end

  def owners
    memberships.owner.collect { |m| m.user }
  end

  def users
    memberships.user.collect { |m| m.user }
  end


  private

  def delete_memberships
    # Delete the memberships without callbacks in order to get around
    # the :validate_group_has_owner Membership callback. Relevant cached 
    # membership info will be deleted by a regex-based callback in this class
    Membership.delete_all(:group_id => self.id)
  end  
  
  def group_has_one_owner
    raise "Group must have at least one owner." if owners.empty? 
  end

  def destroy_viewable_users_cache
    Rails.cache.delete_matched(%r{user-rights-*})
    Rails.cache.delete_matched(%r{groups-viewable-users-*})
    stored_file_ids = stored_files.collect{ |stored_file| stored_file.id }
    Rails.cache.delete_matched(%r{stored-file-#{stored_file_ids}-viewable-users}) if stored_file_ids.present?
  end
end
