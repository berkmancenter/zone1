require 'resque/tasks'

# start rails environment for each worker as it starts up
task "resque:setup" => :environment do
  # Fix for resque workers failing with postgres error after first successful job
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end

