class RemoteFileImporter
  @queue = :remote_file_importer_queue

  def self.perform(sftp_username, file_params)
    ::Rails.logger.debug "PHUNK: RemoteFileImporter firing for sftp_username #{sftp_username}"
    file_params[:skip_quota] = true
    # consider requiring user_id match as well
    sftp_user = SftpUser.find_by_username(sftp_username, :include => :user)
    bytes_used = 0

    #TODO: error handling for each file
    sftp_user.uploaded_files.each do |file_path|
      file_params[:file] = File.open(file_path)
      file_params[:original_filename] = File.basename(file_path)
      stored_file = StoredFile.new
      stored_file.set_fits_attributes(file_path)
      stored_file.custom_save(file_params, sftp_user.user)
      bytes_used += stored_file.file.size
    end

    sftp_user.user.decrease_available_quota!(bytes_used)
    ::Rails.logger.debug "PHUNK: Would sftp_user.destroy here"
    #sftp_user.destroy
  end
  
end
