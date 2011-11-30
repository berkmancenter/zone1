class GroupsController < ApplicationController
  access_control do
    allow logged_in, :to => [:index, :new, :create]

    allow logged_in, :to => [:edit, :update, :destroy], :if => :allow_manage?
  end

  def allow_manage?
    current_user.can_do_group_method?(params[:id], "edit_groups")
  end
  
  def index
    @groups = current_user.all_groups
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
    @members = @group.members
  end

  def create
    begin
      @group = Group.new(params[:group])

      @group.users = User.find_all_by_email(params[:user_email].split(', '))
      @group.owners << current_user

      @group.save
    
      redirect_to edit_group_path(@group)
    rescue Exception => e
      render :json => {:success => 'false', :message => e.to_s}
    end
  end

  def update
    begin
      @group = Group.find(params[:id])

      # Remove by remove params
      @group.users.delete(User.find_all_by_id(params[:remove].keys)) if params.has_key?(:remove)

      # Set owners
      @group.owners = User.find_all_by_id(params[:owner].keys) if params.has_key?(:owner)

      # Add new users
      @group.users << User.find_all_by_email(params[:user_email].split(', '))

      @group.update_attributes(params[:group])

      redirect_to edit_group_path(@group)
    rescue Exception => e
      render :json => { :message => e.to_s }
    end
  end

  def destroy
    begin
      Group.delete(params[:id])

      respond_to do |format|
        format.html { redirect_to groups_url }
        format.json { head :ok }
      end
    rescue Exception => e
      render :json => { :success => 'false', :message => e.to_s }
    end
  end
end
