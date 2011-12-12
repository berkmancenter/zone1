namespace :db do
  desc "Drop, create, migrate, seed, reindex database"
  task :rebuild => [
    'environment',
    'db:no_production_check',
    'db:drop',
    'db:create',
    'db:migrate',
    'db:seed',
    'sunspot:reindex',
    'cache:clear',
    'camp:re_all'

  ]

  task :no_production_check do
    raise "Never run this in production!" if Rails.env == "production"
  end
end

namespace :cache do
  desc "Clear all rails cache"
  task :clear do    
    Rails.cache.clear
  end
end

namespace :camp do
  desc "Restart camp"
  task :re_all do
    `/home/camp/bin/re --all`
  end
end

namespace :resque do
  desc "Kill resque"
  task :kill do
    if File.exist?("#{Rails.root}/var/run/resque-work.pid")
      Process.kill(9, File.read("#{Rails.root}/var/run/resque-work.pid").to_i)
      sleep(2)
      File.delete("#{Rails.root}/var/run/resque-work.pid")
    end
  end
end
