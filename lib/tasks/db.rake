namespace :db do
  desc "Drop, create, migrate, seed, reindex database"
  task :rebuild => :environment do
    `kill \`cat /home/brian/camp16/var/run/resque-work.pid\``
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["sunspot:reindex"].invoke([StoredFile])
    `/home/camp/bin/re --all`
  end
end
