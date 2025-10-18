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

namespace :example do
  task :headlines do
    require_relative 'lib/google_news'
    headlines = GoogleNews.headlines(n: 10, language: 'de', country: 'de')
    headlines.each do |item|
      puts "Title: #{item[:title]}"
      puts "Link: #{item[:link]}"
      puts "Published At: #{item[:pub_date].class}"
      puts "Descriptions: #{item[:descriptions]}"
      puts "-" * 40
    end
  end

end


RSpec::Core::RakeTask.new(:spec)