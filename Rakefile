require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

#
# run default task to see tasks to build and publish gem
#
task :default do
  system 'rake --tasks'
end

task :console do
  require_relative 'lib/google_news'
  require 'pry'
  Pry.start
end

RSpec::Core::RakeTask.new(:spec)