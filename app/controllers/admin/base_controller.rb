class Admin::BaseController < ApplicationController
  include ApplicationHelper

  access_control do
    allow logged_in, :to => [:index, :edit, :show, :destroy, :update, :create], :if => :can_view_admin?
  end

  def can_view_admin?
    current_user.can_do_global_method?("view_admin")
  end

  def index
  end
end
