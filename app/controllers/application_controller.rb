class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Acl9::AccessDenied  do |exception|
    flash[:error] = 'You do not have access to view this page.'
    redirect_to root_url
  end
end
