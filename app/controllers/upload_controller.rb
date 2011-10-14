class UploadController < ApplicationController
  protect_from_forgery #:except => :store_file

  def index
    @stored_file = StoredFile.new
    @stored_file.access_level_id = 3  #todo: just for testing
#    @access_levels = AccessLevel.all
  end


end
