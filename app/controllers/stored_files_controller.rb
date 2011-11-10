class StoredFilesController < ApplicationController
  include RightMethods
  protect_from_forgery
  include ApplicationHelper

  # TODO: Re-add later
  #caches_page :show
  #cache_sweeper :stored_file_sweeper, :only => :show

  access_control do
    allow logged_in, :to => [:create, :new]

    # TODO: Add conditional for batch updates
    # allow logged_in, :to => :batch_edit, :if => :batch_allow_method

    #Toggle methods: flags, tags, various fields, access level
    allow logged_in, :to => :toggle_method, :if => :allow_toggle_method?

    allow logged_in, :to => [:edit, :update], :if => :allow_manage?

    allow logged_in, :to => [:show, :download], :if => :allow_show?

    allow logged_in, :to => :destroy, :if => :allow_destroy?

    # TODO: Add validation for download set later
    allow logged_in, :to => :download_set
  end

  def allow_destroy?
    StoredFile.find(params[:id]).can_user_destroy?(current_user)
  end

  def allow_show?
    stored_file = StoredFile.find(params[:id])
    stored_file.can_user_view?(current_user)
  end

  def allow_manage?
    current_user.can_do_method?(params[:id], "edit_items")
  end

  def allow_toggle_method?
    current_user.can_do_method?(params[:id], params[:method])
  end

  def toggle_method
    self.send(params[:method]) 
  end

  def show
    @stored_file = StoredFile.find(params[:id])
  end

  def download
    @stored_file = StoredFile.find(params[:id])
    # TODO: Ask Phunk to clean this up / refactor
    send_file @stored_file.file.file.file
  end

  def edit
    @licenses = License.all
    @stored_file = StoredFile.find(params[:id], :include => :comments)
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

  def update
    begin
      @stored_file = StoredFile.find(params[:id])

      if params[:stored_file].has_key?(:tag_list)
        @stored_file.update_tags(params[:stored_file][:tag_list], :tags, current_user)
        params[:stored_file].delete(:tag_list)
      end
      if params[:stored_file].has_key?(:collection_list)
        @stored_file.update_tags(params[:stored_file][:collection_list], :collections, current_user)
        params[:stored_file].delete(:collection_list)
      end

      # TODO: Figure out why this attribute is not getting updated in update_attributes 
      #@stored_file.update_attribute(:allow_notes, params[:stored_file][:allow_notes])

      # TODO: Once the :allow_notes issue is fixed, combine these into one update_attributes call
      @stored_file.update_attributes(validate_params(params, @stored_file))
   
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
    @stored_file = StoredFile.new(:user_id => current_user.id)

    # TODO: Figure out if default here
    @stored_file.access_level_id = 3

    init_new_batch
  end
 
  # Server side validation updatable attributes
  def validate_params(params, stored_file)

    # User with view_item access and item can accept comments 
    if params[:stored_file].has_key?(:comment)
      if stored_file.allow_notes && current_user.can_do_method?(stored_file, "view_items")
        comment_params = params[:stored_file].delete(:comment).merge({ :user_id => current_user.id })
        params[:stored_file][:comments_attributes] = [comment_params]
      else
        params[:stored_file].delete(:comment)
      end
    end

    # Ensure user can manage disposition and disposition_action_id is not blank
    if !current_user.can_do_method?(stored_file, "manage_disposition")
      params[:stored_file].delete(:disposition_attributes)
    elsif params[:stored_file].has_key?(:disposition_attributes) && params[:stored_file][:disposition_attributes][:disposition_action_id].blank?
      params[:stored_file].delete(:disposition_attributes)
    end

    if params[:stored_file].has_key?(:access_level_id) && stored_file.access_level_id != params[:stored_file][:access_level_id]
      access_level = AccessLevel.find(params[:stored_file][:access_level_id])
      if !current_user.can_do_method?(stored_file, "toggle_#{access_level.name}")
        params[:stored_file].delete(:access_level_id)
      end
    end

    if params.has_key?(:tag_list)
      params[:stored_file].delete(:tag_list) unless stored_file.allow_tags || current_user.can_do_method?(stored_file, "edit_items")
    end

    params[:stored_file]
  end

  def create
    begin
      if current_user.nil?
        render :json => {:success => false, :message => "It doesn't look like you're logged in."}
        return
      end

      raise Exception.new("Missing temp_batch_id") unless params[:temp_batch_id]

      new_file = StoredFile.new({ :original_filename => params.delete(:name),
        :user_id => current_user.id,
        :file => params.delete(:file)
      })

      stored_file_params = validate_params(params, new_file)
      if new_file.update_attributes(stored_file_params)

        # TODO: Do update_batch first and have it return a batch_id and include that in the new_file.UA call?
        update_batch(params[:temp_batch_id], new_file)

        Resque.enqueue(FitsRunner, new_file.id, new_file.file.url)
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

  def update_batch(temp_batch_id, new_file)
    file_ids = session[:upload_batches][temp_batch_id][:file_ids]

    if file_ids.length == 0
      # Don't treat this like a legit batch yet because there's only one file in it and we
      # can't be sure they'll upload any more. We turn it into a legit Batch instance
      # on the next upload for this temp_batch_id
      # Add new id to session for this temp_batch_id
      file_ids << new_file.id
      return
    end      

    # TODO: I think we should assign directly to batch.stored_file_ids. That would avoid the extra SF.find, too.
    if file_ids.length == 1
      batch = Batch.new(:user_id => current_user.id)
      batch.stored_files << StoredFile.find(file_ids.first.to_i, new_file.id)
      batch.save!
    else
      batch = Batch.find(session[:upload_batches][temp_batch_id][:system_batch_id].to_i)
      batch.stored_files << StoredFile.find(new_file.id)
    end

    # update this temp_batch in the session now that we know the batch update worked
    file_ids << new_file.id
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
