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

  def self.find_by_name_cached(name)
    self.all.detect { |p| p.name == name }
  end

  def self.define_preference_methods
    # Convenience method that defines the recommended API for this model: one class
    # method for each preference.name value out of the database
    self.all.each do |pref|
      pref_symbol = :"#{pref.name}"
      next if self.respond_to? :pref_symbol
      self.define_singleton_method(pref_symbol) { self.find_by_name_cached( pref_symbol.to_s ).try(:value) }
    end
  end

  define_preference_methods

  private

  def destroy_cache
    Rails.cache.delete("preferences")
  end
end
