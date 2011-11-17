class LicenseSweeper < ActionController::Caching::Sweeper
  observe License
   
  def after_create(license)
    destroy_licenses_cache
  end

  def after_update(license)
    destroy_licenses_cache
  end
                         
  def after_destroy(license)
    destroy_licenses_cache
  end

  private

  def destroy_licenses_cache
    Rails.cache.delete("licenses")
  end
end
