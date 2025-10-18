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

task :build_gem do
  version = GoogleNews::VERSION
  gem_file = "google_news-#{version}.gem"
  if File.exist? gem_file
    File.delete gem_file
  end
  system "gem build google_news.gemspec"
end

task :publish => :build_gem do
  version = GoogleNews::VERSION
  gem_file = "google_news-#{version}.gem"
  if File.exist? gem_file
    system "gem push #{gem_file}"
  else
    puts "No gem file found to publish."
  end
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