class StoredFilesController < ApplicationController
  include RightMethods
  protect_from_forgery
  #caches_page :show
  #cache_sweeper :stored_file_sweeper, :only => :show

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
    begin
      @stored_file = StoredFile.find(params[:id])
      @creator = @stored_file.user

      params[:stored_file][:flag_ids] ||= []

      @stored_file.tag_list = params[:stored_file][:tag_list]
      @stored_file.collection_list = params[:stored_file][:collections]
  
      @creator_email = params[:stored_file][:creator_email]
      if @creator_email
        @user = User.find_by_email(@creator_email)
      end

      if @user
        params[:stored_file][:creator_email] = @user.id
      else
        flash[:error] = "Invalid creator email" 
        raise "Invalid creator email"
      end
      
      @stored_file.update_attributes(params[:stored_file])
      
      render :json => { :success => 'true' }
      return
    rescue Exception => e
      render :json => { :status => :unprocessable_entity, :message => e.to_s }
      ::Rails.logger.warn "Warning: stored_files_controller.update got exception: #{e}"
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
      new_file.user_id = current_user.id
      new_file.original_filename = params[:name]
      new_file.content_type = ContentType.first
      new_file.license = License.first

      new_file.save!

      raise Exception.new("Missing temp_batch_id") unless params[:temp_batch_id]
      update_batch(params[:temp_batch_id], new_file)
    
      render :json => {:success => 'true'}
      #render :json => {:success => 'false', :message => 'Server too testy'}
      return
    rescue Exception => e
      render :json => {:success => 'false', :message => e.to_s}
      ::Rails.logger.warn "Warning: stored_files_controller.create exception: #{e}"
    end
  end

  private

  def update_batch(temp_batch_id, new_file)
    file_ids = session[:upload_batches][temp_batch_id][:file_ids]

    if file_ids.length == 0
      # Don't treat this like a legit batch yet because there's only one file in it and we
      # can't be sure they'll upload any more. We turn it into a legit Batch instance
      # on the next upload for this temp_batch_id
      logger.debug "PHUNK: First file in this batch."
      # Add new id to session for this temp_batch_id
      file_ids << new_file.id
      return
    end      

    if file_ids.length == 1
      #logger.debug "PHUNK: Second file in this batch. Create and save new Batch instance"
      batch = Batch.new(:user_id => current_user.id)
      batch.stored_files << StoredFile.find(file_ids.first.to_i, new_file.id)
      batch.save!
    else
      #logger.debug "PHUNK: 3+ file, update existing batch with new_file only"
      batch = Batch.find( session[:upload_batches][temp_batch_id][:system_batch_id].to_i )
      batch.stored_files << StoredFile.find(new_file.id)
    end

    # update this temp_batch in the session now that we know the batch update worked
    file_ids << new_file.id
    session[:upload_batches][temp_batch_id] = {
      :system_batch_id => batch.id,
      :last_modified => Time.now.utc.iso8601,
      :file_ids => file_ids
    }
    logger.debug "PHUNK: updated batch. Session->temp batch: #{session[:upload_batches][temp_batch_id].inspect}"
  end
end
