class AccessLevel < ActiveRecord::Base
  has_many :stored_files
  
  validates_uniqueness_of :name

  attr_accessible :name, :label

  after_save :destroy_access_levels_cache
  after_destroy :destroy_access_levels_cache

  def self.open
    AccessLevel.find_by_label("Open")
  end

  def self.default
    AccessLevel.find_by_label("Partially Open")
  end

  def self.dark
    AccessLevel.find_by_label("Dark")
  end

  def self.all
    Rails.cache.fetch("access-levels") do
      AccessLevel.find(:all)
    end
  end


  private
  
  def destroy_access_levels_cache
    Rails.cache.delete("access-levels") 
  end 

end
