class Admin::FlagsController < Admin::BaseController
  def index
    @flags = Flag.all
    @flag = Flag.new
  end

  def create
    begin
      @flag = Flag.new(params[:flag])
      if @flag.save
        flash[:notice] = "created!"
        redirect_to edit_admin_flag_path(@flag)
      else
        flash[:error] = "Errors #{@flag.errors.full_messages.join(', ')}"
        @flags = Flag.all 
        render 'index'
      end
    rescue Exception => e
      @flag = Flag.new
      flash[:error] = "problems creating. try again."
      log_exception e
      @flags = Flag.all 
      render 'index'
    end
  end

  def update
    begin
      @flag = Flag.find(params[:id])
      @flag.update_attributes(params[:flag])
      flash[:notice] = "updated!"
      @right = Right.find_by_action("toggle_#{@flag.name.downcase}")
      render 'edit'
    rescue Exception => e
      flash[:error] = "Problems updating! Please try again."
      log_exception e
      render 'edit'
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
