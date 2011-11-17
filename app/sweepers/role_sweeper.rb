class RoleSweeper < ActionController::Caching::Sweeper
  observe Role
   
  def after_create(role)
    destroy_viewable_users_cache
  end

  def after_update(role)
    destroy_viewable_users_cache
  end
                         
  def after_destroy(role)
    destroy_viewable_users_cache
  end

  private
  def destroy_viewable_users_cache
    Rails.cache.delete("roles-viewable-users-view_items")
    Rails.cache.delete("roles-viewable-users-view_preserved_flag_content")
  end
end
