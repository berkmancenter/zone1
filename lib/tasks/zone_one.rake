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
end
