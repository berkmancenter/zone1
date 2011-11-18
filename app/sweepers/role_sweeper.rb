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
    Rails.cache.delete_matched(%r{roles-viewable-users-*})
  end
end
