class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def edit
    @role = Role.find(params[:id])
    @rights = Right.all
  end

  def update
    role = Role.find(params[:id])
    role.rights = Right.find(params[:rights].keys)
    role.save
    redirect_to edit_role_path(role)
  end
end
