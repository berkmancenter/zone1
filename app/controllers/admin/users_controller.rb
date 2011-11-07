class Admin::UsersController < Admin::BaseController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    begin
      @user = User.find(params[:id])
      @user.update_attributes(params[:user]) 
      flash[:notice] = "updated!"
      render 'edit'
    rescue Exception => e
      flash[:error] = "problems updating. try again."
      log_exception e
      render 'edit'
    end
  end
end