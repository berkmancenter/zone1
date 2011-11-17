class UserSweeper < ActionController::Caching::Sweeper
  observe User
   
  def after_create(user)
    destroy_viewable_users_cache
  end

  def after_update(user)
    destroy_viewable_users_cache
  end
                         
  def after_destroy(user)
    destroy_viewable_users_cache
  end

  private

  # Note: When a user is added to a group, role, or assigned a right,
  # all of these caches need to be invalidated.
  def destroy_viewable_users_cache
    Rails.cache.delete("users-viewable-users-view_items")
    Rails.cache.delete("users-viewable-users-view_preserved_flag_content")
    Rails.cache.delete("roles-viewable-users-view_items")
    Rails.cache.delete("roles-viewable-users-view_preserved_flag_content")
    Rails.cache.delete("groups-viewable-users-view_items")
    Rails.cache.delete("groups-viewable-users-view_preserved_flag_content")
  end
end
