class Right < ActiveRecord::Base
  validates_presence_of :action

  has_many :right_assignments, :dependent => :destroy
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
    Rails.cache.delete("roles-viewable-users-#{self.action}")
    Rails.cache.delete("users-viewable-users-#{self.action}")
    Rails.cache.delete("groups-viewable-users-#{self.action}")
    if self.action == "view_preserved_flag_content"
      flags = Flag.preservation.map(&:id)
      StoredFile.unscoped.joins(:flaggings).where(:"flaggings.flag_id"=> flags).each do |f|
        Rails.logger.debug "Destroying_cache on stored_file: #{f.id}"
        f.send :destroy_cache
      end
    end   
  end
end
