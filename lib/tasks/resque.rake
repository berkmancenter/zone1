require 'resque/tasks'

namespace :resque do
  desc "Setup resque"
  task :setup do 
    Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  end

  desc "Kill resque"
  task :kill do
    if File.exist?("#{Rails.root}/var/run/resque-work.pid")
      Process.kill(9, File.read("#{Rails.root}/var/run/resque-work.pid").to_i)
      sleep(2)
      File.delete("#{Rails.root}/var/run/resque-work.pid")
    end
  end
end
