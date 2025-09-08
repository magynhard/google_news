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

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.metadata['allowed_push_host'] = "https://rubygems.org"
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rss',      '>= 0.2.6'
  spec.add_runtime_dependency 'open-uri', '>= 0.1.0'

  spec.add_development_dependency 'bundler',  '>= 2.7.1'
  spec.add_development_dependency 'rake',     '~> 12.0'
  spec.add_development_dependency 'rspec',    '~> 3.0'
  spec.add_development_dependency 'pry',     '~> 0.15.2'
  spec.add_development_dependency 'fiddle',   '~> 1.1.8'
  spec.add_development_dependency 'ostruct',  '~> 0.6.3'
end
