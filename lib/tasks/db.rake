namespace :db do
  desc "Drop, create, migrate, seed, reindex database"
  task :rebuild => :environment do
    if File.exist?("#{Rails.root}/var/run/resque-work.pid")
      Process.kill(9, File.read("#{Rails.root}/var/run/resque-work.pid").to_i)
      sleep(2)
      File.delete("#{Rails.root}/var/run/resque-work.pid")
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["sunspot:reindex"].invoke([StoredFile])
    Rails.cache.clear
    `/home/camp/bin/re --all`
  end
end
