# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'football_api/version'

Gem::Specification.new do |spec|
  spec.name          = "football_api"
  spec.version       = FootballApi::VERSION
  spec.authors       = ["Afonso Tsukamoto"]
  spec.email         = ["atsukamoto@faber-ventures.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'reek', '~> 1.3', '>= 1.3.7'
  spec.add_development_dependency 'rubocop', '~> 0.20', '>= 0.20.1'
  spec.add_development_dependency 'pry', '~> 0.9', '>= 0.9.12'
  spec.add_development_dependency 'pry-byebug', '~> 2.0.0'

  spec.add_dependency 'httparty', '~> 0.13', '>= 0.13.0'
  spec.add_dependency 'colored', '~> 1.2'
  spec.add_dependency 'tzinfo', '~> 1.1', '>= 1.1.0'
  spec.add_dependency 'eventmachine', '~> 1.0', '>= 1.0.3'
  spec.add_dependency 'activemodel', '~> 4.1', '>= 4.1.0'
end
