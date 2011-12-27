namespace :camp do
  desc "Rebuild data"
  task :rebuild => :environment do
    `rm -rf #{Rails.root}/uploads/*`
    `if [ -e #{Rails.root}/var/run/resque-work.pid ]; then kill \`cat #{Rails.root}/var/run/resque-work.pid\`; rm #{Rails.root}/var/run/resque-work.pid;fi;`
    sleep(2) #allow time for resque to be killed
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    Rake::Task["sunspot:reindex"].invoke([StoredFile])
    `/home/camp/bin/re --all`
  end
end
