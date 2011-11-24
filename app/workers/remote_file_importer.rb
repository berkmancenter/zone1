class RemoteFileImporter
  @queue = :remote_file_importer_queue

  def self.perform(username, stored_file_string)
    ::Rails.logger.debug "PHUNK: RemoteFileImporter firing for username #{username}"
    sftp_user = SftpUser.find_by_username(username)
    seed_file = JSON.parse(stored_file_string)
    seed_file[:skip_quota] = true
    bytes_used = 0

    #TODO: error handling for each file
    sftp_user.uploaded_files.each do |file_path|
      stored_file = StoredFile.new seed_file
      stored_file.file = File.open(file_path)
      stored_file.original_filename = File.basename(file_path)
      stored_file.set_fits_attributes(file_path)
      stored_file.save!
      #TODO: what to do with a file that doesn't import correctly?
      bytes_used += stored_file.file.size
    end

    sftp_user.user.decrease_available_quota!(bytes_used)
    ::Rails.logger.debug "PHUNK: Would sftp_user.destroy here"
    #sftp_user.destroy
  end
  
end
