class License < ActiveRecord::Base
  belongs_to :stored_file

  attr_accessible :name

  def self.all
    # TODO: Add cache expiration
    Rails.cache.fetch("licenses") do
      License.find(:all)
    end
  end

  def self.name_map
    self.all.inject({}) { |h, license| h[license.id.to_s] = license.name; h }
  end
end
