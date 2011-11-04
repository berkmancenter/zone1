class FitsRunner
  @queue = :fits_queue

  def self.perform(file_id, file_url)
    ::Rails.logger.debug "PHUNK: FitsRunner.perform firing for id/file: #{file_id} - #{file_url}"
    metadata = Fits::analyze(file_url)

    if metadata.class == Hash and metadata.keys.length > 0
      ::Rails.logger.debug "PHUNK: FitsRunner updating metadata attributes with: #{metadata.inspect}"
      begin
        StoredFile.find(file_id).update_attributes(metadata)
        # TODO: Either use update_all or roll your own update that doesn't need the rails environment
        #Avatar.update_all ['migrated_at = ?', Time.now.utc], ['migrated_at > ?', 1.week.ago]
      rescue Exception => e
        ::Rails.logger.warn "Warning: #{self.class}.perform caught exception: #{e}"
        ::Rails.logger.warn "I Backtraced It: #{e.backtrace.inspect}"
      end
    else
      ::Rails.logger.warn "FitsRunner received zero usable data from FITS for id/file #{file_id} - #{file_url}"
      ::Rails.logger.warn "fits metadata was: #{metadata.inspect}"
    end
  end

end
