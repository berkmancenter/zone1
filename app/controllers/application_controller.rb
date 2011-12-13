class ApplicationController < ActionController::Base
  protect_from_forgery

  Warden::Manager.after_authentication do |user, auth, opts|
    Rails.cache.delete("user-rights-#{user.id}")
  end

  # Rescuing from any Access denied messages, generic JSON response or redirect and flash message
  rescue_from Acl9::AccessDenied do |exception|
    respond_to do |format|
      format.json do 
        render :json => { :success => false, :message => "You do not have access to do this action." }
      end
      format.html do
        flash[:error] = 'You do not have access to view this page.'
        redirect_to root_url
      end
    end
  end
end
