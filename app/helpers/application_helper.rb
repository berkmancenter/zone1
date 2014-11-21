module ApplicationHelper

  def can_toggle_admin?
    begin
      current_user.roles.pluck(:name).include?('tester')
    rescue
      binding.pry
      return false
    end
  end

  def admin_stat_helper
    if current_user.roles.pluck(:name).include?('admin')
      'to off'
    else
      'to on'
    end
  end

  def safe_strftime(date,format="%m/%d/%Y")
    if date.present? && date.respond_to?(:strftime)
      date.strftime(format)
    end
  end

  def build_date_from_string_safe(date_string, format="%m/%d/%Y")
    begin
      Date.strptime(date_string, format) if date_string.present? && date_string.is_a?(String)
    rescue Exception => e
      log_exception(e)
      nil
    end
  end

  def log_exception(e, extra=nil)
      logger.warn("***EXCEPTION CAUGHT*** " + e.message)
      logger.warn(extra) if extra
      e.backtrace.each { |trace| logger.debug(trace) }
  end

  def can_view_admin?
    current_user.roles.pluck(:name).include?('admin')
    # current_user.try :can_do_global_method?, "view_admin"
  end
end
