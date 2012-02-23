class RightAssignment < ActiveRecord::Base
  belongs_to :right
  belongs_to :subject, :polymorphic => true
  attr_accessible :right_id

  after_create :destroy_perserved_flag_stored_files_cache
  after_destroy :destroy_perserved_flag_stored_files_cache

  private

  def destroy_perserved_flag_stored_files_cache
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
    
      perserved_flag_ids = Flag.preservation.collect{ |f| f.id }

      # produces SQL:
      # SELECT "stored_files".* FROM "stored_files" INNER JOIN "flaggings" ON "flaggings"."stored_file_id" = "stored_files"."id" WHERE "flaggings"."flag_id" IN (#{perserved_flag_ids})
      # Unscope so that deleted stored files have their caches updated as well
      StoredFile.unscoped.joins(:flaggings).where(:"flaggings.flag_id" => perserved_flag_ids).each do |stored_file|
        StoredFile.send(:destroy_cache, stored_file)
      end
    end
  end
end
