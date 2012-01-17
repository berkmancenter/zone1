class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validate :uniqueness_of_user, :on => :create

  attr_accessible :user, :group, :user_id, :group_id, :is_owner, :joined_at, :invited_by

  scope :invited, where(["joined_at IS ?", nil])
  scope :confirmed, where(["joined_at IS NOT ?", nil])
  scope :owner, where(["is_owner = ?", true])
  scope :user, where(["is_owner = ?", false])

  after_create :send_invitation_email, :if => :invited?
  after_create :destroy_member_cache

  after_destroy :validate_group_has_owner
  after_destroy :destroy_member_cache
  
  after_update :validate_group_has_owner
  after_update :destroy_member_cache

  def accept(time=Time.now)
    update_attribute(:joined_at, time)
    destroy_member_cache
  end

  def invited_by_name
    user = User.find_by_id(invited_by)
    user.try(:name)
  end

  def send_invitation_email
    if invited?
      generate_membership_code
      UserMailer.membership_invitation_email(self).deliver
    end
  end

  def generate_membership_code
    update_attribute(:membership_code, ::SecureRandom.hex)
  end

  def is_owner?
    is_owner
  end

  def is_user?
    !is_owner?
  end

  def invited?
    !confirmed?
  end

  def confirmed?
    joined_at.present?
  end
  
  def self.invite_users_to_groups(users, groups, options={})
    # A user is assumed to be invited until the joined_at date
    # is set via the confirmation process
    options.with_defaults!(:is_owner => false, :joined_at => nil)
    create_with_options(users, groups, options)
  end

  def self.add_users_to_groups(users, groups, options={})
    # By setting the joined_at time we skip the invitation process
    options.with_defaults!(:is_owner => false, :joined_at => Time.now)
    create_with_options(users, groups, options)
  end

  private

  def validate_group_has_owner
    raise "Groups must have at least one owner." if group.owners.empty? || Membership.where(:group_id => group.id, :is_owner => true).empty?
  end

  def uniqueness_of_user
    # check database and object state
    raise "#{user.email} already belongs to group #{group.name}." if Membership.where(:group_id => group.id, :user_id => user.id).present?
  end

  def self.create_with_options(users, groups, options)

    new_memberships = []

    Membership.transaction do

      users.each do |user|
        groups.each do |group|
          attributes = options.merge(:user => user, :group => group)
          new_memberships << create!(attributes)

        end #groups.each
      end #users.each
    end #transaction

    new_memberships

  end #create_with_options

  private
  
  def destroy_member_cache
    Rails.cache.delete("user-rights-#{user.id}")
    Rails.cache.delete("groups-viewable-users-#{group.id}")
    stored_file_ids = group.stored_files.collect{ |stored_file| stored_file.id }
    Rails.cache.delete_matched(%r{stored-file-#{stored_file_ids}-viewable-users}) if stored_file_ids.present?
  end
end
