class Admin::BaseController < ApplicationController
  layout "admin"
  include ApplicationHelper
  cache_sweeper :preference_sweeper, :only => :update

  access_control do
    allow logged_in, :to => [:index, :edit, :show, :destroy, :update, :create], :if => :can_view_admin?
  end

  def can_view_admin?
    current_user.can_do_global_method?("view_admin")
  end

  def index
    @preferences = Preference.all
  end

  def update
    params[:preference].each do |k, v|
      Preference.find(k).update_attribute(:value, v)
    end
    flash[:notice] = "Updated!"
    redirect_to "/admin"
  end
end
