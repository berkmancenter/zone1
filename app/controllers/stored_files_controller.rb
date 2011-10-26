class StoredFilesController < ApplicationController
  include RightMethods
  protect_from_forgery

  access_control do
    allow all, :to => :index
    allow logged_in, :to => :create

    #Toggle methods: flags, tags, various fields, access level
    allow logged_in, :to => :toggle_method, :if => :allow_toggle_method

    # additional acl9 methods:
    allow logged_in, :to => [:edit, :update], :if => :allow_update_or_edit

    allow logged_in, :to => :show, :if => :allow_show

    # delete (delete_items, delete_items_to_own_content
    allow logged_in, :to => :destroy, :if => :allow_destroy
  end 

  def allow_destroy
    true
  end

  def allow_show
    return true if current_user.can_do_method?(params[:id], "view_items") 

    stored_file = StoredFile.find(params[:id])
    return true if stored_file.access_level.name == "open" 

    return true if current_user.list_rights.include?("view_preserved_flag_content") && 
      stored_file.has_preserved_flag?
    true #false
  end

  def allow_update_or_edit
    #if current user has some toggle rights, check here
    true
  end

  def allow_toggle_method
    current_user.can_do_method?(params[:id], params[:method])
  end

  def toggle_method
    self.send(params[:method]) 
  end

  # GET /storedfiles
  def index
    @stored_files = StoredFile.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /storedfiles/1
  def show
    @stored_file = StoredFile.find(params[:id])
  end

  # GET /storedfiles/1/edit
  def edit
    @stored_file = StoredFile.find(params[:id])
	respond_to do |format|
		format.html { render :layout => false }
	end
  end

  # PUT /storedfiles/1
  # PUT /storedfiles/1.json
  def update
    @stored_file = StoredFile.find(params[:id])
    respond_to do |format|
      if @stored_file.update_attributes(params[:stored_file])
        format.json { head :ok }
      else
        format.json { render :json => @stored_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /storedfiles/1
  # DELETE /storedfiles/1.json
  def destroy
    @stored_file = Storedfile.find(params[:id])
    @stored_file.destroy

    respond_to do |format|
      format.html { redirect_to storedfiles_url }
      format.json { head :ok }
    end
  end

  def create
    begin
      if current_user.nil?
        render :json => {:success => 'false', :message => "It doesn't look like you're logged in."}
        return
      end

      params[:stored_file][:file] = params.delete(:file)
      new_file = StoredFile.new(params[:stored_file])
      #todo: validate access_level_id is allowed, based on user permissions
      new_file.user_id = current_user.id
      new_file.original_filename = params[:name]
      new_file.content_type_id = ContentType.first.id

      new_file.save!
      ::Rails.logger.debug "PHUNK: new file url #{new_file.file.url}"
      render :json => {:success => 'true'}
      #render :json => {:success => 'false', :message => 'Server too testy'}
      return
    rescue Exception => e
      render :json => {:success => 'false', :message => e.to_s}
      ::Rails.logger.warn "Warning: stored_files_controller.create got exception: #{e}"
    end
  end
end
