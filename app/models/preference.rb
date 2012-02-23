class Preference < ActiveRecord::Base
  validates_presence_of :name, :value
  attr_accessible :name, :value

  # Caching related callbacks
  after_save :destroy_cache
  after_destroy :destroy_cache

  def self.all
    Rails.cache.fetch("preferences") do
      Preference.find(:all)
    end
  end

  def self.find_by_name_cached(name)
    Preference.all.detect { |p| p.name == name }
  end 

  def self.default_user_upload_quota
    Preference.find_by_name_cached("Default User Upload Quota").try(:value)
  end

  def self.max_web_upload_filesize
    Preference.find_by_name_cached("Max Web Upload Filesize").try(:value)
  end

  def self.default_license
    license_preference = Preference.find_by_name_cached("Default License").try(:value)
    License.find_by_name(license_preference) if license_preference
  end

  def self.group_invite_from_address
    Preference.find_by_name_cached("Group Invite Email From Address").try(:value)
  end

  def self.retention_period
    Preference.find_by_name_cached("Retention Period in Days for Deleted Files").try(:value).to_i
  end

  # TODO: Use constants for :name, or at least add a :display value that the user sees,
  # then make :name something more constant-ish and programatically friendly
  # e.g. :name => 'max_http_upload_file_size', :display => 'Maximum filesize that can be uploaded via the Web UI (KB)'
  private

  def destroy_cache
    Rails.cache.delete("preferences")
  end
end
