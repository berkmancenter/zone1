class AccessLevel < ActiveRecord::Base
  has_many :stored_files
  
  validates_uniqueness_of :name

  attr_accessible :name, :label

  after_save :destroy_cache
  after_destroy :destroy_cache


  def self.open
    self.cached_find_by_name('open')
  end

  def self.default
    self.cached_find_by_name('partially_open')
  end

  def self.dark
    self.cached_find_by_name('dark')
  end

  def self.all
    Rails.cache.fetch("access-levels") do
      AccessLevel.find(:all)
    end
  end

  def self.cached_find_by_name(name)
    self.all.detect {|access_level| access_level.name == name}
  end
    

  private
  
  def destroy_cache
    Rails.cache.delete("access-levels") 
  end 

end
