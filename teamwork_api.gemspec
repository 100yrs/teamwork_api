# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teamwork_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'teamwork_api'
  spec.version       = TeamworkApi::VERSION
  spec.authors       = ['Nick Coyne']
  spec.email         = ['nick@100yea.rs']

  spec.summary       = 'Allows access to the Teamwork API'
  spec.description   = 'Teamwork API'
  spec.homepage      = 'http://github.com/100yrs/teamwork_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.10'
  spec.add_dependency 'rack', '>= 1.6'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'guard', '~> 2.14'


  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3.0'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.69.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.3.0'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'webmock', '~> 2.0'
end
