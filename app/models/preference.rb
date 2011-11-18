class Preference < ActiveRecord::Base
  validates_presence_of :name, :value
  attr_accessible :name, :value

  def self.all
    Rails.cache.fetch("preferences") do
      Preference.find(:all)
    end
  end

  def self.find_by_name_cached(name)
    Preference.all.detect { |p| p.name == name }
  end 
end
