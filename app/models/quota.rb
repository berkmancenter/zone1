class Quota < ActiveRecord::Base

  include ActionView::Helpers::NumberHelper

  belongs_to :user
  validates_presence_of :user, :max
  validates :max, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :used, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}

  def self.decrease_available_for(stored_file)
    quota = Quota.find_by_user_id(stored_file.user_id)
    amount = stored_file.file_size
    
    if quota.available?(amount)
      logger.debug("quota.used=" + quota.used.to_s)
      logger.debug("amount=" + amount.to_s)
      quota.update_attribute(:used, quota.used+amount.to_i)   
    
    else
      raise "Uploading this file would exceed your quota"
    
    end
  end

  def self.increase_available_for(stored_file)
    quota = Quota.find_by_user_id(stored_file.user_id)
    amount = stored_file.file_size

    if quota.will_be_zeroed?(amount)
      quota.update_attribute(:used, 0)

    else
      quota.update_attribute(:used, quota.used-amount.to_i)

    end
  end

  def percent_available
    (used.to_f / max.to_f)*100
  end

  def available?(amount)
    used+amount.to_i <= max
  end

  def will_be_zeroed?(amount)
    used-amount.to_i <= 0
  end
end
