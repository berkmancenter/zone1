namespace :zone_one do
  desc "Clear all low level caches"
  task :clear_cache do   
    # Rails.cache.clear is not working, so system call made.
    # ::Rails.cache.clear
    system("rm -rf #{Rails.root}/tmp/cache/*") 
  end

  desc "Create tables, seed database.  Index Solr.  Clear /tmp"
  task :first_run => [
    'environment',
    'no_production_check',
    'db:migrate',
    'db:seed',
    'tmp:clear',
    'sunspot:reindex'
  ]

  desc "Hard delete expired stored files"
  task :hard_delete_expired_stored_files => :environment do
    retention_period = Preference.retention_period
    if retention_period != 0
      StoredFile.unscoped.where(["deleted_at <= ?", retention_period.days.ago]).each do |stored_file|
        ::Rails.logger.debug "Hard deleting stored file: #{stored_file.inspect}"
        stored_file.__send__(:_mounter, :file).remove!
        stored_file.destroy        
      end
    end
  end
end
