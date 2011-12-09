class License < ActiveRecord::Base
  belongs_to :stored_file

  attr_accessible :name

  # Caching related callbacks
  after_update { License.destroy_cache }
  after_create { License.destroy_cache }
  after_destroy { License.destroy_cache }

  def self.all
    Rails.cache.fetch("licenses") do
      License.find(:all)
    end
  end

  def self.facet_label(value)
    self.all.detect { |l| l.id == value.to_i }.name
  end

  private

  def self.destroy_cache
    Rails.cache.delete("licenses")
  end
end
