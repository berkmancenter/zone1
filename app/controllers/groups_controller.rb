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
    @members = []

    respond_to do |format|
      format.js
    end
  end

  def edit
    @group = Group.find(params[:id])
    @members = @group.members

    respond_to do |format|
      format.js
    end
  end

  def create
    begin
      @group = Group.new(params[:group])

      if @group.save
        @group.users = User.find_all_by_email(params[:user_email].split(', '))
        @group.owners << current_user
      else
        raise @group.errors.full_messages.join(', ')
      end
   
      respond_to do |format|
        format.js
      end
    rescue Exception => e
      respond_to do |format|
        format.js do
          @message = e.to_s
          render "create_fail"
        end
      end
    end
  end

  def update
    begin
      @group = Group.find(params[:id])


      if @group.update_attributes(params[:group])
        # Remove by remove params
        @group.users.delete(User.find_all_by_id(params[:remove].keys)) if params.has_key?(:remove)

        # Set owners
        @group.owners = User.find_all_by_id(params[:owner].keys) if params.has_key?(:owner)

        # Add new users
        @group.users << User.find_all_by_email(params[:user_email].split(', '))
      else
        raise @group.errors.full_messages.join(', ')
      end

      respond_to do |format|
        format.js
      end
    rescue Exception => e
      respond_to do |format|
        format.js do
          @message = e.to_s
          render "update_fail"
        end
      end
    end
  end

  def destroy
    begin
      Group.delete(params[:id])

      respond_to do |format|
        format.js
      end
    rescue Exception => e
      respond_to do |format|
        @message = e.to_s
        render 'destroy_fail'
      end
    end
  end
end
