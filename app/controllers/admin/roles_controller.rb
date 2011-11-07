class Admin::RolesController < Admin::BaseController
  def index
    @roles = Role.all
    @role = Role.new
  end

  def show
    redirect_to edit_admin_role_path(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
    @rights = Right.all
  end

  def create
    begin
      @role = Role.new(params[:role])
      if @role.save
        flash[:notice] = "Updated!"
        redirect_to edit_admin_role_path(@role)
      else
        flash[:notice] = "Errors: #{@role.errors.full_messages.join(', ')}"
        @roles = Role.all
        render 'index'
      end
    rescue Exception => e
      flash[:error] = "Problems creating! Please try again."
      log_exception e
      render 'index'
    end
  end

  def update
    begin
      @rights = Right.all
      @role = Role.find(params[:id])
      @role.update_attributes(params[:role])
      @role.rights = Right.find(params[:rights].keys)
      @role.save
      flash[:notice] = "Updated!"
      render 'edit'
    rescue Exception => e
      flash[:error] = "Problems updating! Please try again."
      log_exception e
      render 'edit'
    end
  end
end
