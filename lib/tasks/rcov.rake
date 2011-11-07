# Forked to get it working with Rails 3 and RSpec 2
#
# From http://github.com/jaymcgavren
#
# Save this as rcov.rake in lib/tasks and use rcov:all =>
# to get accurate spec/feature coverage data
#
# Use rcov:rspec or rcov:cucumber
# to get non-aggregated coverage reports for rspec or cucumber separately

require "rspec/core/rake_task"

namespace :rcov do
  
  RSpec::Core::RakeTask.new(:rspec_run) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.rcov = true
    t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/ --output "public/coverage"}
  end
  
  desc "Run both specs and features to generate aggregated coverage"
  task :all do |t|
    rm "coverage.data" if File.exist?("coverage.data")
    Rake::Task["rcov:rspec_run"].invoke
  end
  
  desc "Run only rspecs"
  task :rspec do |t|
    rm "coverage.data" if File.exist?("coverage.data")
    Rake::Task["rcov:rspec_run"].invoke
  end
  
end
