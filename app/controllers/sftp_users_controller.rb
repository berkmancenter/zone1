class SftpUsersController < ApplicationController
  include ApplicationHelper

  protect_from_forgery :except => :create

  def create
    begin
      raise Exception.new("It doesn't look like you're logged in.") if current_user.nil?
      user = SftpUser.new(:user_id => current_user.id)
      user.save!
      render :json => { :u => user.username, :p => user.raw_password }
      #render :json => { :u => 'user7122EA49', :p => '30e8f6017ad7e543' }
      return
    rescue Exception => e
      log_exception e
      render :status => :error, :json => { :message => e.to_s }
      return
    end
  end

end
