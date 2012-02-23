class Right < ActiveRecord::Base
  validates_presence_of :action

  has_many :right_assignments
  has_many :roles,
    :through => :right_assignments,
    :source => :subject,
    :source_type => "Role"

  attr_accessible :action, :description, :role_ids

  # Use after_update instead of after_save because new rights have no roles
  # assigned to them, so there's no need to expire any caches. The relevant
  # caches only need to be expired when changes are made to this right's roles.  
  after_update :destroy_cache
  after_destroy :destroy_cache


  private

  def destroy_cache
    # Same as role.rb
    Rails.cache.delete_matched(%r{user-rights-*})
    Rails.cache.delete("user-rights")
    Rails.cache.delete_matched(%r{roles-viewable-users-*})
  end
end
