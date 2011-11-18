class PreferenceSweeper < ActionController::Caching::Sweeper
  observe Preference
   
  def after_create(preference)
    destroy_preferences_cache
  end

  def after_update(preference)
    destroy_preferences_cache
  end
                         
  def before_destroy(preference)
    destroy_preferences_cache
  end

  private

  def destroy_preferences_cache
    Rails.cache.delete("preferences")
  end
end
