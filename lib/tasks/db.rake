namespace :db do
  desc "Drop, create, migrate, seed, reindex database"
  task :rebuild => :environment do
    `if [ -e #{Rails.root}/var/run/resque-work.pid ]; then kill \`cat #{Rails.root}/var/run/resque-work.pid\`; rm #{Rails.root}/var/run/resque-work.pid;fi;`
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["sunspot:reindex"].invoke([StoredFile])
    `/home/camp/bin/re --all`
  end
end
