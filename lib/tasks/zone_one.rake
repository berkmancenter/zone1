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

  desc "Hard delete expired stored files"
  task :hard_delete_expired_stored_files => :environment do
    retention_period = Preference.soft_delete_retention_period.to_i
    if retention_period != 0
      StoredFile.unscoped.where(["deleted_at <= ?", retention_period.days.ago]).each do |stored_file|
        ::Rails.logger.debug "Hard deleting stored file: #{stored_file.id}"
        stored_file.destroy_without_commit! rescue nil
      end

      # Now do a single commit for all these hard deletes in the search index
      Sunspot.commit
    end
  end

  desc "Delete expired pending group invites"
  task :delete_expired_pending_group_invites => :environment do
    retention_period = Preference.group_invite_pending_duration.to_i
    if retention_period != 0
      Membership.where("updated_at <= ? AND joined_at IS NULL" , retention_period.days.ago).destroy_all.inspect
    end
  end
end
