class GroupSweeper < ActionController::Caching::Sweeper
  observe Group
   
  def after_create(group)
    destroy_viewable_users_cache
  end

  def after_update(group)
    destroy_viewable_users_cache
  end
                         
  def after_destroy(group)
    destroy_viewable_users_cache
  end

  private
  def destroy_viewable_users_cache
    Rails.cache.delete("groups-viewable-users-view_items")
    Rails.cache.delete("groups-viewable-users-view_preserved_flag_content")
  end
end
