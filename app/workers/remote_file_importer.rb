class RemoteFileImporter
  @queue = :remote_file_importer_queue

  def self.perform(sftp_username, file_params)
    ::Rails.logger.info "RemoteFileImporter firing for sftp_username: #{sftp_username}"
    sftp_user = SftpUser.find_by_username(sftp_username)
    bytes_used = 0

    exceptions = {}
    sftp_user.uploaded_files.each do |file_path|
      begin
        file_params[:original_filename] = File.basename(file_path)
        file_params[:file] = File.open(file_path)
        stored_file = StoredFile.new
        stored_file.skip_quota = true
        stored_file.custom_save(file_params, sftp_user.user)
        stored_file.post_process
        bytes_used += stored_file.file.size
      rescue Exception => e
        exceptions[file_params[:original_filename]] = e.to_s
      end
    end

    # TODO: Email user a summary/confirmation of job completion, especially any errors
    if !exceptions.empty?
      ::Rails.logger.warn "RemoteFileImporter errors found: #{exceptions.inspect}"
    end

    # skip_quota was in effect (see above), so debit this user's quota once for total bytes used
    sftp_user.user.decrease_available_quota!(bytes_used)
    ::Rails.logger.debug "PHUNK: Would sftp_user.destroy here"
    #sftp_user.destroy  #TODO: uncomment this and re-test SFTP directory deletion
  end
  
end
