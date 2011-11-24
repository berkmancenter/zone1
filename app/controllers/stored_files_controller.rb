class StoredFilesController < ApplicationController
  protect_from_forgery
  include ApplicationHelper
  cache_sweeper :stored_file_sweeper, :only => [:update, :destroy]

  access_control do
    allow logged_in, :to => [:create, :new]

    allow logged_in, :to => :bulk_edit

    allow logged_in, :to => [:update, :edit, :download], :if => :allow_show?

    allow logged_in, :to => :destroy, :if => :allow_destroy?

    allow logged_in, :to => :download_set, :if => :download_set?
  end

  def allow_destroy?
    StoredFile.find(params[:id]).can_user_destroy?(current_user)
  end

  # Note: View/edit are on same form now, so this is really "can the user view or edit"
  def allow_show?
    StoredFile.cached_viewable_users(params[:id]).include?(current_user.id)
  end

  # TODO: Update this later to handle stored file params
  def download_set?
    true
  end

  def download
    @stored_file = StoredFile.find(params[:id])
    # TODO: Ask Phunk to clean this up / refactor
    send_file @stored_file.file.file.file
  end

  def edit
    @licenses = License.all
    @stored_file = StoredFile.find(params[:id], :include => [:comments, :access_level, :groups, :flags])

    @attr_accessible = @stored_file.attr_accessible_for({}, current_user)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    begin
      StoredFile.find(params[:id]).destroy
      respond_to do |format|
        format.json { render :json => { :success => true } }
        format.html do
          flash[:notice] = "deleted"
          redirect_to root_path
        end
      end
    rescue Exception => e
      log_exception e
      respond_to do |format|
        format.json { render :json => { :success => false, :message => e.to_s } }
        format.html do
          flash[:error] = "Problem deleting file: #{e}"
          ::Rails.logger.warn "Warning: stored_files_controller.delete got exception: #{e}"
          @stored_file = StoredFile.find(params[:id])
          redirect_to edit_stored_file_path(@stored_file)
        end
      end
    end
  end

  def bulk_edit
    redirect_to new_bulk_edit_path(:stored_file_ids => params[:stored_file].keys)
  end 

  def update
    begin
      @stored_file = StoredFile.find(params[:id])

      @stored_file.custom_save(params[:stored_file], current_user)
   
      respond_to do |format|
        format.js
        format.json { render :json => { :success => true } }
        format.html do
          flash[:error] = "success"
          redirect_to edit_stored_file_path(@stored_file)
        end
      end
    rescue Exception => e
      log_exception e
      respond_to do |format|
        format.json { render :json => { :success => false, :message => e.to_s } }
        format.html do
          flash[:error] = "File update failed: #{e}"
          redirect_to edit_stored_file_path(@stored_file)
        end
      end
    end
  end

  def new
    @licenses = License.all
    @stored_file = StoredFile.new

    @attr_accessible = @stored_file.attr_accessible_for({}, current_user)
    
    # Note: This is important, to be set after initialized because
    # accessible attributes are defined by attr_accessible_for, 
    # and access_level_id and user_id are not global attributes
    # TODO: Possibly clean up later, but low priority
    @stored_file.user_id = current_user.id
    @stored_file.access_level_id = 3
    @max_web_upload_file_size = Preference.find_by_name('Max Web Upload Filesize').try(:value)
    @max_web_upload_file_size ||= '100mb' #arbitrary default. (standard 'mb', 'kb', 'b' units required)

    init_new_batch
  end
 

  def create
    # Note: We jump through some logical hoops to delay saving the new StoredFile 
    # instance if this is a SFTP-only request. This is how we avoid saving orphaned
    # StoredFile instances to the DB during a SFTP-only request.
    if current_user.nil?
      render :json => {:success => false, :message => "It doesn't look like you're logged in."}
      return
    end

    begin
      is_web_upload = params.has_key?(:name) && params.has_key?(:file)
      is_sftp_only = params[:sftp_only] == '1'

      @stored_file = StoredFile.new

      # Note: This is done because the custom_save handles accepted attributes
      params[:stored_file].merge!({ :original_filename => params.delete(:name),
        :user_id => current_user.id,
        :file => params.delete(:file)
      })
      if @stored_file.custom_save(params[:stored_file], current_user)

        # TODO: Do update_batch first and have it return a batch_id and include that in the @stored_file.UA call?
        update_batch(params[:temp_batch_id], @stored_file)

        Resque.enqueue(FitsRunner, @stored_file.id, @stored_file.file.url)
        render :json => {:success => true} && return

#CONFLICT      stored_file_params = validate_params(params, new_file)
#CONFLICT      stored_file_params[:group_ids] = params[:groups].keys if params.has_key?(:groups)
      #TODO: TEST: I'm not sure :group_ids is going to work with the below .send() stuff. 
#CONFLICT      stored_file_params.each do |attr, value|
#CONFLICT        new_file.send("#{attr}=", value)
#CONFLICT      end

#      new_file.content_type = new_file.file.file.content_type rescue ''

      sftp_user = SftpUser.find_by_username(params[:sftp_username]) if params[:sftp_username].present?
      force_batch = is_sftp_only || (is_web_upload && sftp_user && needs_remote_file_import?(sftp_user))

      if !is_sftp_only
        new_file.save!
        Resque.enqueue(FitsRunner, new_file.id)
      end

      # If this is a web-upload, we update_batch _after_ new_file.save! so we'll have a new_file.id
      new_file.batch_id = update_batch(params[:temp_batch_id], new_file.id, force_batch)

      # If we have a new batch_id value that we need to update in the new_file 
      # instance we just saved. Specifically, this will not happen if is_sftp_only.
      if new_file.batch_id && new_file.persisted?
        new_file.update_attribute(:batch_id, new_file.batch_id)
      end

      if needs_remote_file_import?(sftp_user)
        # Make sure the remote file import job only gets enqueued ONCE for this temp_batch_id
        session[:remote_import_temp_batch_ids] ||= {}
        session[:remote_import_temp_batch_ids][params[:temp_batch_id]] = true
        Resque.enqueue(RemoteFileImporter, params[:sftp_username], new_file.to_json)
      end

      render :json => {:success => true}
      return
    rescue Exception => e
      log_exception(e)
      render :json => {:success => false, :message => e.to_s}
      return
    end
  end

  def download_set
    selected_stored_file_ids = params[:stored_file].collect { |k,v| k.to_i }
    selected_files = StoredFile.find(selected_stored_file_ids)

    set = DownloadSet.new(selected_files)
    
    send_file set.path

    #TODO when we get the x_sendfile implemented, we will need a cron script to do the clean up
    File.delete(set.path) if File.file?(set.path)
  end


  private

  def needs_remote_file_import?(sftp_user)
    return @needs_remote_file_import = false if sftp_user.nil?

    if @needs_remote_file_import.nil? 
      @needs_remote_file_import = !( session[:remote_import_temp_batch_ids] &&
        session[:remote_import_temp_batch_ids][params[:temp_batch_id]] ) &&
        sftp_user.uploaded_files?
    end
    @needs_remote_file_import
  end

  def update_batch(temp_batch_id, new_file_id, force_create)
    # Returns: batch.id if a batch was created/found AND new_file_id should be
    # assigned to that batch. Returns nil if no batch created/found (in which
    # case, new_file_id does not need to be assigned to any batch.)
    file_count = session[:upload_batches][temp_batch_id][:file_count]
    first_file_id = session[:upload_batches][temp_batch_id][:first_file_id]

    # Get batch from session
    if session[:upload_batches][temp_batch_id][:system_batch_id].present?
      batch = Batch.find(session[:upload_batches][temp_batch_id][:system_batch_id].to_i)
    else
      if (force_create && batch.nil?) || file_count == 1
        batch = Batch.new(:user_id => current_user.id)
        batch.save!
      end
    end

    # Populate first_file_id. Harmless no-op if new_file_id is nil.
    first_file_id ||= new_file_id

    # If there was previously one persisted file in this temp batch, add
    # it to this new batch instance. This is how we retroactively include a
    # previous single-file upload (which does not get a Batch instance) 
    if file_count == 1 && first_file_id
      batch.stored_files << StoredFile.find_by_id(first_file_id.to_i)
    end

    # Update this temp_batch entry in the session
    session[:upload_batches][temp_batch_id] = {
      :system_batch_id => batch.try(:id),
      :updated_at => Time.now.utc.iso8601,
      :file_count => file_count + 1,
      :first_file_id => first_file_id
    }

    return batch.try(:id)
  end

  def init_new_batch
    # A new @temp_batch_id is created for each view of stored_files#new. That
    # is how we group all web/sftp files uploaded from that single view, into
    # the same Batch instance.
    session[:upload_batches] ||= {}
    expire_stale_temp_batches

    @temp_batch_id = Batch.new_temp_batch_id
    session[:upload_batches][@temp_batch_id] = {
      :system_batch_id => nil,
      :updated_at => Time.now.utc.iso8601,
      :file_count => 0,
      :first_file_id => nil
    }
  end

  def expire_stale_temp_batches(max_age_hours=72)
    # Remove temp_batch_id hashes from the session if they are more than X hours stale
    return unless session[:upload_batches].present?

    stale_ids = []
    session[:upload_batches].each do |temp_batch_id, batch_info|
      diff = DateTime.parse(Time.now.utc.iso8601) - DateTime.parse(batch_info[:updated_at])
      foo, hours, = Date.day_fraction_to_time diff
      stale_ids << temp_batch_id if hours >= max_age_hours
    end

    stale_ids.each do |temp_batch_id|
      session[:upload_batches].delete temp_batch_id
    end
  end

end
