namespace :zone_one do

  desc "Clear all low level caches"
  task :clear_cache => :environment do
    Rails.cache.clear
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

  # TODO: This only operates on soft-deleted files, which is not exactly the spirit of Preference.retention_period.
  desc "Hard delete expired stored files"
  task :hard_delete_expired_stored_files => :environment do
    retention_period = Preference.retention_period
    if retention_period != 0
      StoredFile.unscoped.where(["deleted_at <= ?", retention_period.days.ago]).each do |stored_file|
        ::Rails.logger.debug "Hard deleting stored file: #{stored_file.id}"
        stored_file.destroy_without_commit! rescue nil
      end

      # Now do a single commit for all these hard deletes in the search index
      Sunspot.commit
    end
  end
end
