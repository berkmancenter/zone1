class AccessLevel < ActiveRecord::Base
  has_many :stored_files
  
  validates_uniqueness_of :name

  attr_accessible :name, :label

  after_update { AccessLevel.destroy_access_levels_cache }
  after_create { AccessLevel.destroy_access_levels_cache }
  after_destroy { AccessLevel.destroy_access_levels_cache }

  def self.default
    AccessLevel.find_by_label("Partially Open")
  end

  def self.destroy_access_levels_cache
    Rails.cache.delete("access-levels") 
  end 

  def self.all
    Rails.cache.fetch("access-levels") do
      AccessLevel.find(:all)
    end
  end
end
