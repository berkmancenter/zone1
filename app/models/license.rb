class License < ActiveRecord::Base
  attr_accessible :name

  # Caching related callbacks
  after_create :destroy_cache
  after_destroy :destroy_cache

  def self.all
    Rails.cache.fetch("licenses") do
      License.find(:all)
    end
  end

  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.name
  end

  private

  def destroy_cache
    Rails.cache.delete("licenses")
  end
end
