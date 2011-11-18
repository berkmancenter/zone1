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

    init_new_batch
  end
 

  def create
    begin
      if current_user.nil?
        render :json => {:success => false, :message => "It doesn't look like you're logged in."}
        return
      end

      raise Exception.new("Missing temp_batch_id") unless params[:temp_batch_id]

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
        render :json => {:success => true}
      else
        raise "StoredFile not created. see logs!"
      end
    rescue Exception => e
      log_exception(e)
      render :json => {:success => false, :message => e.to_s}
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

  def update_batch(temp_batch_id, stored_file)
    file_ids = session[:upload_batches][temp_batch_id][:file_ids]

    if file_ids.length == 0
      # Don't treat this like a legit batch yet because there's only one file in it and we
      # can't be sure they'll upload any more. We turn it into a legit Batch instance
      # on the next upload for this temp_batch_id
      # Add new id to session for this temp_batch_id
      file_ids << stored_file.id
      return
    end      

    # TODO: I think we should assign directly to batch.stored_file_ids. That would avoid the extra SF.find, too.
    if file_ids.length == 1
      batch = Batch.new(:user_id => current_user.id)
      batch.stored_files << StoredFile.find(file_ids.first.to_i, stored_file.id)
      batch.save!
    else
      batch = Batch.find(session[:upload_batches][temp_batch_id][:system_batch_id].to_i)
      batch.stored_files << StoredFile.find(stored_file.id)
    end

    # update this temp_batch in the session now that we know the batch update worked
    file_ids << stored_file.id
    session[:upload_batches][temp_batch_id] = {
      :system_batch_id => batch.id,
      :last_modified => Time.now.utc.iso8601,
      :file_ids => file_ids
    }
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

    # Remove any stale temp batches we just found
    stale_ids.each do |temp_batch_id|
      session[:upload_batches].delete temp_batch_id
    end
  end

end
