class FlagSweeper < ActionController::Caching::Sweeper
  observe Flag
   
  def after_create(flag)
    destroy_flags_cache
  end

  def after_update(flag)
    destroy_flags_cache
  end
                         
  def before_destroy(flag)
    destroy_flags_cache
  end

  private

  def destroy_flags_cache
    Rails.cache.delete("flags")
  end
end
