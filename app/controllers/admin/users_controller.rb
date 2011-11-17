class Admin::UsersController < Admin::BaseController
  cache_sweeper :user_sweeper

  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end

  def edit
    @user = User.find(params[:id], :include => :roles)
    @roles = Role.all
    @rights = Right.all
  end

  def update
    begin
      user = User.find(params[:id])
      user.update_attributes(params[:user]) 
      flash[:notice] = "updated!"
      redirect_to edit_admin_user_path(user)
    rescue Exception => e
      flash[:error] = "problems updating. try again."
      log_exception e
      redirect_to edit_admin_user_path(user)
    end
  end
end
