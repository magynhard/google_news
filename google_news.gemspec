# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'google_news/version'

Gem::Specification.new do |spec|
  spec.name          = "google_news"
  spec.version       = GoogleNews::VERSION
  spec.executables   = %w[google_news]
  spec.authors       = ["Matthäus J. N. Beyrle"]
  spec.email         = ["google_news.gemspec@mail.magynhard.de"]

  spec.summary       = %q{Get Google News headlines from Ruby or the command line.}
  spec.homepage      = "https://github.com/magynhard/google_news"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rss',      '>= 0.2.6'
  spec.add_runtime_dependency 'open-uri', '>= 0.1.0'

  spec.add_development_dependency 'bundler',  '>= 2.0'
  spec.add_development_dependency 'rake',     '>= 10.0'
  spec.add_development_dependency 'rspec',    '>= 3.0'
  spec.add_development_dependency 'pry',     '>= 0.10.0'
end
