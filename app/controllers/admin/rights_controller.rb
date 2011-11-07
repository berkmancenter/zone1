class Admin::RightsController < Admin::BaseController
  def index
    @rights = Right.all
    @right = Right.new
  end

  def create
    begin
      @right = Right.new(params[:right])
      if @right.save
        flash[:notice] = "created!"
        redirect_to edit_admin_right_path(@right)
      else
        flash[:notice] = "Errors #{@right.errors.full_messages.join(', ')}"
        @rights = Right.all
        render 'index'
      end
    rescue Exception => e
      flash[:error] = "Problems creating! Please try again."
      log_exception e
      @rights = Right.all
      render 'index'
    end
  end

  def show
    redirect_to edit_admin_right_path(params[:id])
  end

  def update
    begin
      @right = Right.find(params[:id])
      @right.update_attributes(params[:right])
      flash[:notice] = "updated!"
      render 'edit'
    rescue Exception => e
      flash[:error] = "Problems updating! Please try again."
      log_exception e
      render 'edit'
    end
  end

  def edit
    @right = Right.find(params[:id])
  end

  def destroy
    Right.delete(params[:id])
    flash[:notice] = "Deleted right."
    redirect_to admin_rights_path
  end
end
