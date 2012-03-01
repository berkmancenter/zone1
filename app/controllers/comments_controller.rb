class CommentsController < ApplicationController
  access_control do
    allow logged_in, :to => :destroy, :if => :allow_destroy?
  end

  def allow_destroy?
    comment = Comment.find(params[:id], :include => :user)
    return true if comment.user == current_user

    current_user.can_do_method?(params[:stored_file_id], "delete_comments")
  end

  def destroy
    begin
      Comment.destroy(params[:id])
      head :ok
    rescue Exception => e
      render :json => { :success => false, :message => e.to_s }
    end
  end
end
