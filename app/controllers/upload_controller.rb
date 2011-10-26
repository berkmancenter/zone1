class UploadController < ApplicationController

  def index
    @stored_file = StoredFile.new
    @stored_file.access_level_id = 3  #todo: just for testing
    init_new_batch
  end


  private

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
