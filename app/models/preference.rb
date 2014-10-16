class Preference < ActiveRecord::Base
  validates_presence_of :name, :label, :value
  validates_uniqueness_of :name, :label
  attr_accessible :name, :label, :value

  after_save :destroy_cache
  after_destroy :destroy_cache

  def self.all
    Rails.cache.fetch("preferences") do
      Preference.find(:all)
    end
  end

  def self.cached_find_by_name(name)
    self.all.detect { |p| p.name == name }.try(:value)
  end


  private

  def destroy_cache
    Rails.cache.delete("preferences")
  end
end
