class StoredFilesController < ApplicationController
  # GET /storedfiles
  # GET /storedfiles.json
  def index
    @storedfiles = StoredFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @storedfiles }
    end
  end

  # GET /storedfiles/1
  # GET /storedfiles/1.json
  def show
    @storedfile = StoredFile.find(params[:id])

    respond_to do |format|
      format.html do
		render 'show'  # show.html.erb
	  end
    end
  end

  # GET /storedfiles/new
  # GET /storedfiles/new.json
  def new
    @storedfile = StoredFile.new

    respond_to do |format|
      format.html # new.html.erb
    end
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

  # POST /storedfiles
  # POST /storedfiles.json
  def create
    @storedfile = StoredFile.new(params[:storedfile])

    respond_to do |format|
      if @storedfile.save
        format.html { redirect_to @storedfile, :notice => 'Storedfile was successfully created.' }
        format.json { render :json => @storedfile, :status => :created, :location => @storedfile }
      else
        format.html { render :action => "show" }
	  end
    end
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
end
