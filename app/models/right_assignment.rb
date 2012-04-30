class RightAssignment < ActiveRecord::Base
  belongs_to :right
  belongs_to :subject, :polymorphic => true
  attr_accessible :right_id

  after_create :destroy_cache
  after_destroy :destroy_cache

  private

  def destroy_cache
    if right.action == "view_preserved_flag_content"

      # Must delete this cache first so when StoredFile.cached_viewable_users 
      # rebuilds it doesn't build from a stale cache.

      case subject_type  
      when "User"
        Rails.cache.delete("users-viewable-users-view_preserved_flag_content")
      when "Group"
        Rails.cache.delete("groups-viewable-users-view_preserved_flag_content")
      when "Role"
        Rails.cache.delete("roles-viewable-users-view_preserved_flag_content")
      end
    
      perserved_flag_ids = Flag.preservation.map(&:id)

      # Unscope so that soft-deleted stored files have their caches updated as well
      StoredFile.unscoped.joins(:flaggings).where(:"flaggings.flag_id" => perserved_flag_ids).each do |stored_file|
        StoredFile.send(:destroy_cache, stored_file)
      end
    end
  end
end
