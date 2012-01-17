class Group < ActiveRecord::Base

  has_many :memberships, :include => :user
  has_many :groups_stored_files
  has_many :stored_files, :through => :groups_stored_files
  has_many :rights, :through => :right_assignments
  has_many :right_assignments, :as => :subject

  acts_as_authorization_subject :association_name => :roles, :join_table_name => :roles_groups

  validates_presence_of :name  
  validates_uniqueness_of :name

  # Can't create group if it won't pass the validation
  # so only validate owner is set on update
  validate :group_has_one_owner, :on => :update

  # Instead of using the typical :dependent => :destroy option
  # We create our own callback to clean up memberships
  # while still being able to enforce :group_has_one_owner constrant
  before_destroy :delete_memberships

  attr_accessible :name, :assignable_rights, :right_ids, :memberships_attributes

  # Caching related callbacks
  after_update :destroy_viewable_users_cache
  after_create :destroy_viewable_users_cache
  after_destroy :destroy_viewable_users_cache


  accepts_nested_attributes_for :memberships, :allow_destroy => true

  def allowed_rights
    self.assignable_rights ? self.rights : []
  end

  def self.cached_viewable_users(right)
    Rails.cache.fetch("groups-viewable-users-#{right}") do
      User.find_by_sql("SELECT u.id
        FROM users u
        JOIN memberships m ON u.id = m.user_id
        JOIN groups g ON g.id = m.group_id
        JOIN right_assignments ra ON ra.subject_id = m.group_id
        JOIN rights r ON r.id = ra.right_id
        WHERE ra.subject_type = 'Group'
        AND g.assignable_rights
        AND m.joined_at IS NOT NULL
        AND r.action = '#{right}'").collect { |user| user.id }
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




  # Helper methods to manage group owners and users
  def set_owners(new_owners)
    # Will help make users into owners

    raise "Group must have at least one owner." if new_owners.empty?

    Group.transaction do

      # process existing memberships
      memberships.each do |member|

        if new_owners.include?(member.user)

          if member.is_user?
            # make existing members owners if they are currently users
            member.update_attribute(:is_owner, true)
          end

          new_owners -= [member.user] #consider this new owner processed
        
        elsif member.is_owner?
          # remove owners who are not in new_owner
          # without callback to avoid group_has_owner validation
          member.delete



        end # if
      end # memberships

      Membership.add_users_to_groups(new_owners, [self], :is_owner => true)

    end # transactions
  end

  def set_users(new_users)
    # Will make owners become users
    Group.transaction do

      # process existing memberships
      memberships.each do |member|

        if new_users.include?(member.user)

          if member.is_owner?
            # make existing members users if they are currently owners
            member.update_attribute(:is_owner, false)
          end

          new_users -= [member.user] #consider this new user processed
        
        elsif member.is_user?
          # remove users who are not in new_user
          member.destroy


        end # if
      end # memberships

      Membership.add_users_to_groups(new_users, [self])

    end # transactions
    Group.transaction do

      memberships.each do |member|
        if users.include?(member.user)
          if member.is_owner?
            member.update_attribute(:is_owner, false)
            users 
          end
        end
      end
    end
  end
  
  def delete_members(users)
    user_ids = users.collect { |user| user.id }
    Membership.destroy_all(:group_id => self.id, :user_id => user_ids)
  end

  



  # Convenience methods which scope according to their name. 
  # All these methods return an array of users. 
  # The has_many :memberships includes users so
  # the SQL for this collection is efficent and NOT N+1
  def members
    # Returns users
    memberships.collect { |m| m.user }
  end
  
  def invited_members
    # Returns users
    memberships.invited.collect{ |m| m.user }
  end

  def confirmed_members
    # Returns users
    memberships.confirmed.collect { |m| m.user }
  end

  def owners
    # Returns users
    memberships.owner.collect { |m| m.user }
  end

  def users
    # Returns users
    memberships.user.collect { |m| m.user }
  end


  def delete_memberships
    # Becasue the memberships verify there is at least one owner
    # for a group before destoying, we must delete the memberships
    # without callbacks.
    memberships.delete_all
  end  
  
  
  private

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
