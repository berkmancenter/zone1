class FitsRunner

  include ApplicationHelper

  @queue = :fits_queue

  def self.perform(file_id)
    ::Rails.logger.debug "PHUNK: FitsRunner firing for file id: #{file_id}"
    StoredFile.find(file_id).update_fits_attributes
  end

end
