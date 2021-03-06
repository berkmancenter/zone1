class RemoteFileImporter
  @queue = :remote_file_importer

  def self.perform(sftp_username, params)
    sftp_user = SftpUser.find_by_username(sftp_username)
    raise "No such SFTP username: #{sftp_username}" if sftp_user.nil?

    bytes_used = 0
    exceptions = []
    file_list = []

    sftp_user.uploaded_files.each do |file_path|
      begin
        params[:original_filename] = File.basename(file_path)
        params[:file] = File.open(file_path)
        stored_file = StoredFile.new
        stored_file.defer_quota_update = true
        stored_file.custom_save(params, sftp_user.user)
        stored_file.post_process
        bytes_used += stored_file.file.size
        file_list << stored_file.original_filename
      rescue Exception => e
        exceptions << [params[:original_filename], e]
      end
    end

    # If we created any new files, force Sunspot to update its index on disk to pick them up
    Sunspot.commit unless file_list.empty?

    # TODO: Email user a summary/confirmation of job completion, especially any errors
    if !exceptions.empty?
      exceptions.each do |exception|
        ::Rails.logger.warn "RemoteFileImporter errors found for #{exception[0]}"
        ::Rails.logger.warn exception[1].inspect
        ::Rails.logger.warn "BACKTRACE:"
        exception[1].backtrace.each do |backtrace_line|
          ::Rails.logger.warn backtrace_line
        end
      end
    end

    # defer_quota_update was in effect (see above), so debit this user's quota once for total bytes used
    sftp_user.user.decrease_available_quota!(bytes_used)
    sftp_user.destroy
  end
  
end
