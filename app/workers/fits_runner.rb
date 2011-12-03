class FitsRunner

  include ApplicationHelper

  @queue = :fits_queue

  def self.perform(file_id)
    stored_file = StoredFile.find(file_id)
    if stored_file.update_fits_attributes
      stored_file.file.fits_complete = true
      stored_file.process_images
    end
  end

end
