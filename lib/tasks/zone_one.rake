namespace :zone_one do
  desc "Clear all low level caches"
  task :clear_cache do   
    # Rails.cache.clear is not working, so system call made.
    # ::Rails.cache.clear
    system("rm -rf #{Rails.root}/tmp/cache/*") 
  end

  desc "Drop, create, migrate, seed database.  Index Solr.  Clear /tmp"
  task :setup => [
    'environment',
    'no_production_check',
    'db:drop',
    'db:create',
    'db:migrate',
    'db:seed',
    'sunspot:reindex',
    'tmp:clear'
  ]
end
