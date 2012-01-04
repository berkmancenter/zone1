namespace :camp do
  
  desc "Drop, create, migrate, seed, reindex database"
  task :rebuild => [
    'environment',
    'no_production_check',
    'camp:restart',
    'db:drop',
    'db:create',
    'db:migrate',
    'db:seed',
    'sunspot:reindex',
    'tmp:clear',
    'camp:restart'
  ]

  desc "Restart camp"
  task :restart do
    `re --all`
  end  
end

desc "Raise error if run in production"
task :no_production_check do
  raise "Never run this in production!" if Rails.env == "production"
end
