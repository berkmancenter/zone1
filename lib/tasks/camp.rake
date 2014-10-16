namespace :camp do
  
  desc "camp:restart, db:reset, db:seed, tmp:clear:, camp:restart database"
  task :rebuild => [
    'environment',
    'no_production_check',
    'camp:restart',
    'db:reset',
    'db:seed',
    'tmp:clear',
    'camp:restart'
  ]

  desc "Restart camp"
  task :restart do
    `re --all`
  end 

 desc "Setup test users"
  task :test_users do
    Rake::Task['environment'].invoke
    test_users_file = File.join(Rails.root, 'db', 'test_users.rb')
    load(test_users_file) if File.exist?(test_users_file)
  end 
end

desc "Raise error if run in production"
task :no_production_check do
  raise "Never run this in production!" if Rails.env == "production"
end
