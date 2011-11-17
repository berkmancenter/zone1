class Admin::RolesController < Admin::BaseController
  cache_sweeper :role_sweeper

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
        redirect_to admin_roles_path
      end
    rescue Exception => e
      flash[:error] = "Problems creating! Please try again."
      log_exception e
      redirect_to admin_roles_path
    end
  end

  def update
    begin
      role = Role.find(params[:id])
      role.update_attributes(params[:role])
      flash[:notice] = "Updated!"
      redirect_to edit_admin_role_path(role)
    rescue Exception => e
      flash[:error] = "Problems updating! Please try again. #{e.inspect}."
      log_exception e
      redirect_to edit_admin_role_path(role)
    end
  end

  def destroy
    Role.delete(params[:id])
    flash[:notice] = "Deleted role."
    redirect_to admin_roles_path
  end
end
