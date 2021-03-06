class Admin::BaseController < ApplicationController
  include ApplicationHelper
  require 'zone1/fits'
  add_breadcrumb "current search", :search_path
  access_control do
    allow logged_in, :to => [:index, :edit, :show, :destroy, :update, :create], :if => :can_view_admin?
  end

  def index
    @preferences = Preference.all.sort_by(&:name)
    add_breadcrumb "admin: app configuration", :admin_path 
  end

  def update
    params[:preference].each do |k, v|
      begin
        if k == 'fits_script_path'
          Fits.validate_fits_script_path(v)
        end

        Preference.find_by_name(k).update_attributes(:value => v)
      rescue Exception => e
        flash[:error] = "Could not update '#{Preference.find_by_name(k).label}' because: #{e}"
      end
    end

    flash[:notice] = "Preferences updated"
    redirect_to "/admin"
  end
end
