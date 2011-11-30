class Preference < ActiveRecord::Base
  validates_presence_of :name, :value
  attr_accessible :name, :value

  # Caching related callbacks
  after_update { Preference.destroy_cache }
  after_create { Preference.destroy_cache }
  after_destroy { Preference.destroy_cache }

  def self.all
    Rails.cache.fetch("preferences") do
      Preference.find(:all)
    end
  end

  def self.find_by_name_cached(name)
    Preference.all.detect { |p| p.name == name }
  end 

  # TODO: Use constants for :name, or at least add a :display value that the user sees,
  # then make :name something more constant-ish and programatically friendly
  # e.g. :name => 'max_http_upload_file_size', :display => 'Maximum filesize that can be uploaded via the Web UI (KB)'
  private

  def self.destroy_cache
    Rails.cache.delete("preferences")
  end
end
