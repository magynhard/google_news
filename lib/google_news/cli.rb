require 'optparse'
require 'json'
require_relative '../google_news'

module GoogleNews
  #
  # Command-line interface for GoogleNews
  #
  class CLI
    def self.run(args = ARGV)
      options = { n: 10, language: 'en' }
      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: google_news [options]"
        opts.on('-tTOPIC', '--topic=TOPIC', 'Get news for a specific topic. One of: WORLD, NATION, BUSINESS, TECHNOLOGY, ENTERTAINMENT, SPORTS, SCIENCE, HEALTH') do |topic|
          options[:topic] = topic
        end
        opts.on('-gPOSITION', '--geo=POSITION', 'Get news for a specific geographic location, e.g. "48.8566,2.3522" for Paris') do |position|
          options[:geo] = position
        end
        opts.on('-cCOUNTRY', '--country=COUNTRY', 'Country code, e.g. "us" for United States (default: us)') do |country|
          options[:country] = country
        end
        opts.on('-lLANGUAGE', '--language=LANGUAGE', 'Language code, e.g. "en" for English (default: en)') do |language|
          options[:language] = language
        end
        opts.on('-nN', '--n=N', Integer, 'Number of headlines to fetch (default: 10)') do |n|
          options[:n] = n
        end
        opts.on('-h', '--help', 'Show this help message') do
          puts opts
          exit
        end
      end
      begin
        opt_parser.parse!(args)
      rescue OptionParser::InvalidOption => e
        puts e.message
        puts opt_parser
        exit 1
      end
      show_logo
      begin
        if options[:headlines]
          headlines = GoogleNews.headlines(country: options[:country] || 'us', language: options[:language] || 'en', n: options[:n] || 10)
        elsif options[:topic]
          headlines = GoogleNews.topic(options[:topic], country: options[:country] || 'us', language: options[:language] || 'en', n: options[:n] || 10)
        elsif options[:geo]
          headlines = GoogleNews.geo(options[:geo], country: options[:country] || 'us', language: options[:language] || 'en', n: options[:n] || 10)
        else
          headlines = GoogleNews.headlines(country: options[:country] || 'us', language: options[:language] || 'en', n: options[:n] || 10)
        end
      end
      puts headlines.to_json
    end

    def self.show_logo
      puts
      puts "GoogleNews CLI v#{GoogleNews::VERSION} - Get Google News headlines from Ruby or the command line."
      puts ""
      puts "Powered by the 'google_news' Ruby gem"
      puts ""
    end

  end
end