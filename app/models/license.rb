class License < ActiveRecord::Base
  belongs_to :stored_file

  attr_accessible :name

  # Caching related callbacks
  after_update { License.destroy_cache }
  after_create { License.destroy_cache }
  after_destroy { License.destroy_cache }

  def self.all
    # TODO: Add cache expiration
    Rails.cache.fetch("licenses") do
      License.find(:all)
    end
  end

  def self.name_map
    self.all.inject({}) { |h, license| h[license.id.to_s] = license.name; h }
  end

  private

  def self.destroy_cache
    Rails.cache.delete("licenses")
  end
end
