class GroupsController < ApplicationController
  
  before_filter :mailer_set_url_options, :on => [:create, :update]
  
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

    respond_to do |format|
      format.js
    end
  end

  def edit
    @group = Group.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    begin
      @group = Group.new(params[:group])

      Group.transaction do

        if @group.save
          Membership.add_users_to_groups([current_user], [@group], :is_owner => true)
          @group.invite_users_by_email(params[:user_email].split.uniq, current_user)
        else
          raise @group.errors.full_messages.join(', ')
        end
  
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

      Group.transaction do

        if @group.update_attributes(params[:group])
          # Invite new users
          @group.invite_users_by_email(params[:user_email].split.uniq, current_user)
        else
          raise @group.errors.full_messages.join(', ')
        end

      end

      respond_to do |format|
        format.js
      end
    rescue Exception => e
      respond_to do |format|
        format.js do
          log_exception e
          @message = e.to_s
          render "update_fail"
        end
      end
    end
  end

  def destroy
    begin
      Group.destroy(params[:id]) # fire callbacks

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

  private
  def mailer_set_url_options
    # Because we email from inside the model, we must tell the mailer
    # what our host URL is from inside the controller.
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
