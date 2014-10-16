class Admin::FlagsController < Admin::BaseController
  add_breadcrumb "admin: flags", :admin_flags_path
  def index
    @flags = Flag.all
    @flag = Flag.new
  end

  def create
    begin
      flag = Flag.new(params[:flag])
      if flag.save
        flag_name = flag.name.downcase
        flash[:notice] = "Created! Your new flag will not be available to anyone until you create rights for it (e.g. add_#{flag_name}, remove_#{flag_name})"
      else
        flash[:error] = "Errors #{flag.errors.full_messages.join(', ')}"
      end
    rescue Exception => e
      flash[:error] = "problems creating. "
      log_exception e
    end
    redirect_to admin_flags_path
  end

  def update
    begin
      flag = Flag.find(params[:id])
      flag.update_attributes(params[:flag])
      flash[:notice] = "updated!"
    rescue Exception => e
      flash[:error] = "Problems updating!"
      log_exception e
    end
    redirect_to edit_admin_flag_path(flag)
  end

  def show
    redirect_to edit_admin_flag_path(params[:id])
  end

  def edit
    @flag = Flag.find(params[:id])
    @right = Right.find_by_action("toggle_#{@flag.name.downcase}")
    add_breadcrumb "edit #{@flag.name}", edit_admin_flag_path(params[:id])
  end

  def destroy
    begin 
      Flag.destroy(params[:id])
      flash[:notice] = "Deleted flag."
    rescue Exception => e
      flash[:error] = "Problems deleting: #{e}"
      log_exception e
    end
    redirect_to admin_flags_path
  end

end
