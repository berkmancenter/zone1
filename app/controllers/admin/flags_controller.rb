class Admin::FlagsController < Admin::BaseController
  def index
    @flags = Flag.all
    @flag = Flag.new
  end

  def create
    begin
      flag = Flag.new(params[:flag])
      if flag.save
        flash[:notice] = "created!"
        redirect_to edit_admin_flag_path(flag)
      else
        flash[:error] = "Errors #{flag.errors.full_messages.join(', ')}"
        redirect_to admin_flags_path
      end
    rescue Exception => e
      flash[:error] = "problems creating. try again."
      log_exception e
      redirect_to admin_flags_path
    end
  end

  def update
    begin
      flag = Flag.find(params[:id])
      flag.update_attributes(params[:flag])
      flash[:notice] = "updated!"
      redirect_to edit_admin_flag_path(flag)
    rescue Exception => e
      flash[:error] = "Problems updating! Please try again."
      log_exception e
      redirect_to edit_admin_flag_path(flag)
    end
  end

  def show
    redirect_to edit_admin_flag_path(params[:id])
  end

  def edit
    @flag = Flag.find(params[:id])
    @right = Right.find_by_action("toggle_#{@flag.name.downcase}")
  end

  def destroy
    Flag.delete(params[:id])
    flash[:notice] = "Deleted flag."
    redirect_to admin_flags_path
  end
end
