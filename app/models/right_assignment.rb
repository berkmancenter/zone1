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
      Rails.cache.delete("#{subject_type.to_s.downcase}s-viewable-users-view_preserved_flag_content")
    
      preserved_flag_ids = Flag.preservation.map(&:id)

      # Unscope so that soft-deleted stored files have their caches updated as well
      StoredFile.unscoped.joins(:flaggings).where(:"flaggings.flag_id" => preserved_flag_ids).each do |stored_file|
        Rails.logger.debug "PHUNK: SFuj destroying_cache on stored_file: #{stored_file.id}"
        stored_file.send :destroy_cache
      end
    end
  end
end
