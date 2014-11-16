# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'zone1'
set :repo_url, 'git@git.metabahn.net:client/zone1.git'

set :deploy_to, '/var/apps/zone1'
set :scm, :git
# set :branch, :develop

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{.env config/database.yml config/sunspot.yml config/resque.yml config/application.yml}
set :linked_dirs, %w{log system public/static solr}

set :rbenv_ruby, '2.1.2'
set :rack_env, :staging

namespace :db do
  task :create do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env, 'staging') do
          execute :bundle, 'exec', :rake, 'db:create'
        end
      end
    end
  end
  task :reset do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env, 'staging') do
          execute :bundle, 'exec', :rake, 'db:reset'
        end
      end
    end
  end
end

namespace :deploy do
  before :updated, :setup_solr_data_dir do
    on roles(:app) do
      unless test "[ -d #{shared_path}/solr/data/staging/ ]"
        execute :mkdir, "-p #{shared_path}/solr/data/staging/"
      end
    end
  end

  desc 'Start application'
  task :start do
    on roles(:app) do
      execute "sudo service thin start"
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app) do
      execute "sudo service thin stop"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')

      execute "sudo service thin restart"
    end
  end


  after :publishing, :restart

  after :finishing, 'deploy:cleanup'

end

namespace :db do
  desc "destroy then migrate database"
  task :reset do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env, 'staging') do
          execute :bundle, 'exec', 'rake', 'db:reset' 
        end
      end
    end
  end

  desc "reload the database with seed data"
  task :seed do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env, 'staging') do
          execute :bundle, 'exec', 'rake', 'seed' 
        end
      end
    end
  end
end

 
namespace :solr do
  %w[start stop].each do |command|
    desc "#{command} solr"
    task command do
      on roles(:app) do
        solr_pid = "#{shared_path}/pids/sunspot-solr.pid"
        if command == "start" or (test "[ -f #{solr_pid} ]" and test "kill -0 $( cat #{solr_pid} )")
          within current_path do
            with rails_env: fetch(:rails_env, 'staging') do
              execute :bundle, 'exec', 'sunspot-solr', command, "--port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
            end
          end
        end
      end
    end
  end
  desc "restart solr"
  task :restart do
    invoke 'solr:stop'
    invoke 'solr:start'
  end
  after 'deploy:finished', 'solr:restart'
  desc "reindex the whole solr database"
  task :reindex do
    invoke 'solr:stop'
    on roles(:app) do
      execute :rm, "-rf #{shared_path}/solr/data"
    end
    invoke 'solr:start'
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env, 'staging') do
          info "Reindexing Solr database"
          execute :bundle, 'exec', :rake, 'sunspot:solr:reindex[,,true]'
        end
      end
    end
  end
end
