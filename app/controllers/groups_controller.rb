class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @status = []
  end

  def new
    @group = Group.new
    @emails = []
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
    @emails = @group.users.map { |user| user.email }
  end

  def create
    begin
      @group = Group.new(params[:group])
      emails = params[:user_email].split(',')
      emails.each do |user_email|
        @group.users << User.find_by_email(user_email)
      end

      @group.save
      redirect_to(@group)
    rescue Exception => e
      render :json => {:success => 'false', :message => e.to_s}
      ::Rails.logger.warn "Warning: groups_controller.create got exception: #{e}"
    end
  end

  def update
    begin
      @group = Group.find(params[:id])
      # If the add button is pressed.
      if params[:commit] == "Add"
		# TODO: Clean this up a lot (Evan)
        emails = params[:user_email].split(',')
        emails.each do |user_email|
          @group.users << User.find_by_email(user_email)
        end
        # Ignore changes to the group when Add is pressed.
        params[:group] = nil 
      elsif params[:commit] == "Update"
        # TODO: Clean this up a lot (Evan)

        params[:user_email] = nil

        # Remove users that have been checked.
        params[:group][:user_ids].each do |id|
          if id != ''
            @group.users = @group.users - User.find(id).to_a
          end
        end
        # Change ownership based on checkboxes.
        @group.owners = []
        params[:group][:owner_ids].each do |id|
          if id != ''
            @group.owners << User.find(id)
          end
        end
        @group.save
      end
      redirect_to group_path(@group)
    rescue Exception => e
      render :json => { :message => e.to_s }
      ::Rails.logger.warn "Warning: groups_controller.update got exception: #{e}"
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
      ::Rails.logger.warn "Warning: groups_controller.destroy got exception: #{e}"
    end
  end
end
