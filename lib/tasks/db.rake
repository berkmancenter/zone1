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
