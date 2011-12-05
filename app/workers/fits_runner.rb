class FitsRunner

  include ApplicationHelper

  @queue = :fits_queue

  def self.perform(file_id)
    Rails.logger.debug "!!!!!!!!!!!!!running fits!"
    stored_file = StoredFile.find(file_id)
    if stored_file.update_fits_attributes
      Rails.logger.debug "!!!!!!!!!!!!!!!processing images!"
      stored_file.process_images
    end
  end

end
