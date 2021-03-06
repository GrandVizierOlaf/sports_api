# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sports_api/version'

Gem::Specification.new do |spec|
  spec.name          = "sports_api"
  spec.version       = SportsApi::VERSION
  spec.authors       = ["Mike Silvis"]
  spec.email         = ["mikesilvis@gmail.com"]

  spec.summary       = %q{Get scores for various leagues.}
  spec.description   = %q{Using this awesome gem}
  spec.homepage      = "https://github.com/MikeSilvis/sports_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'faraday'
  spec.add_dependency 'activesupport'
end
