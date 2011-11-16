class AccessLevel < ActiveRecord::Base
  has_many :stored_files
  
  validates_uniqueness_of :name

  attr_accessible :name, :label

  def self.all
    # TODO: Add cache expiration / sweepers
    Rails.cache.fetch("access-levels") do
      AccessLevel.find(:all)
    end
  end
end
