class StoredFilesController < ApplicationController
  include RightMethods
  protect_from_forgery
  #caches_page :show
  #cache_sweeper :stored_file_sweeper, :only => :show

  access_control do
    allow all, :to => :index
    allow logged_in, :to => [:create, :new]

    # allow logged_in, :to => :batch_edit, :if => :batch_allow_method

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

    # add does user have right to view own file

    # does user groups have access to view file and is file partially open 

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

      @stored_file.update_attributes(validate_params(params, @stored_file))
      
      render :json => { :success => 'true' }
    rescue Exception => e
      render :json => { :status => :unprocessable_entity, :message => e.to_s }
      ::Rails.logger.warn "Warning: stored_files_controller.update got exception: #{e}"
    end
  end

  def new
    @stored_file = StoredFile.new

    # Important: For appropriate permissions to be shown
	@stored_file.user = current_user 

    @stored_file.access_level_id = 3  #todo: just for testing
    init_new_batch
  end
 
  # Method used for both update and create
  def validate_params(params, stored_file)
    # Server side validation on rights to update
    if !current_user.can_do_method?(stored_file, "update_disposition")
      params[:stored_file].delete(:disposition)
    end

    if stored_file.access_level_id != params[:stored_file][:access_level_id]
      access_level = AccessLevel.find(params[:stored_file][:access_level_id])
      if !current_user.can_do_method?(stored_file, "toggle_#{access_level.name}")
        params[:stored_file].delete(:access_level_id)
      end
    end

    if params.has_key?(:flags)
      new_flags = stored_file.flags.collect { |f| f.id }
      params[:flags].each do |k, v|
        if current_user.can_do_method?(stored_file, "toggle_#{k}")
          new_flags << Flag.find_by_name(k.upcase).id
        end
      end
      params[:stored_file][:flag_ids] = new_flags  
    end 		
    params[:stored_file]
  end

  def create
    begin
      if current_user.nil?
        render :json => {:success => 'false', :message => "It doesn't look like you're logged in."}
        return
      end

      new_file = StoredFile.new({ :original_filename => params[:name],
        :user_id => current_user.id,
        :content_type_id => ContentType.first.id }) #Note: First content type id for testing
      params[:stored_file][:file] = params.delete(:file)
      stored_file_params = validate_params(params, new_file)
      new_file.update_attributes(stored_file_params)

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

  def init_new_batch
    session[:upload_batches] ||= {}
    expire_stale_temp_batches
    @temp_batch_id = new_temp_batch_id
    session[:upload_batches][@temp_batch_id] = {
      :system_batch_id => nil,
      :last_modified => Time.now.utc.iso8601,
      :file_ids => []
    }
  end

  def new_temp_batch_id
    # just some small-ish string with good-enough randomness
    SecureRandom.hex(2)
  end

  def expire_stale_temp_batches(max_age_hours = 4)
    # Remove temp_batch_id hashes from the session if they are more than X hours stale
    return if !session[:upload_batches].present?

    stale_ids = []
    session[:upload_batches].each do |temp_batch_id, batch_info|
      diff = DateTime.parse(Time.now.utc.iso8601) - DateTime.parse(batch_info[:last_modified])
      foo, hours, = Date.day_fraction_to_time diff
      stale_ids << temp_batch_id if hours >= max_age_hours
    end

    # Now remove any stale temp batches we just found
    stale_ids.each do |temp_batch_id|
      logger.debug "PHUNK: Deleting stale temp_batch_id from session: #{temp_batch_id}"
      session[:upload_batches].delete temp_batch_id
    end
  end
end
