class StoredFilesController < ApplicationController
  protect_from_forgery

  # GET /storedfiles
  def index
    @storedfiles = StoredFile.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /storedfiles/1
  def show
    @storedfile = StoredFile.find(params[:id])

    #respond_to do |format|
    #  format.html do
	#	render 'show'  # show.html.erb
	#  end
    #end
  end

  # GET /storedfiles/new
  def new
    @storedfile = StoredFile.new

    #respond_to do |format|
    #  format.html # new.html.erb
    #end
  end

  # GET /storedfiles/1/edit
  def edit
    @storedfile = StoredFile.find(params[:id])
	respond_to do |format|
		format.html { render :layout => false }
	end

	# returnining a form
    # set layout false
    # HTML
  end

  # PUT /storedfiles/1
  # PUT /storedfiles/1.json
  def update
    @storedfile = StoredFile.find(params[:id])
    respond_to do |format|
      if @storedfile.update_attributes(params[:stored_file])
        format.json { head :ok }
      else
        format.json { render :json => @storedfile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /storedfiles/1
  # DELETE /storedfiles/1.json
  def destroy
    @storedfile = Storedfile.find(params[:id])
    @storedfile.destroy

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
      new_file.content_type_id = 1 #todo: from FITS

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
