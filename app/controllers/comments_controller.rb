class CommentsController < ApplicationController
  access_control do
    allow logged_in, :to => :destroy, :if => :allow_destroy?
    allow logged_in, :to => :create, :if => :allow_create?
  end

  def allow_destroy?
    comment = Comment.find(params[:id], :include => :user)
    return true if comment.user == current_user

    current_user.can_do_method?(params[:stored_file_id], "delete_comments")
  end

  def allow_create?
    StoredFile.cached_viewable_users(params[:stored_file_id]).include?(current_user.id)
  end

  def destroy
    begin
      Comment.delete(params[:id])
      render :json => { :success => true }
    rescue Exception => e
      render :json => { :success => false, :message => e.to_s }
    end
  end

  def create
    begin
      params[:comment].merge!({ :user_id => current_user.id, :stored_file_id => params[:stored_file_id] })
      c = Comment.new(params[:comment])
      if c.save
        render :json => { :success => true }
      else
        render :json => { :success => false, :message => c.errors.full_messages.join(",") }
      end
    rescue Exception => e
      render :json => { :success => false, :message => e.to_s }
    end
  end
end
