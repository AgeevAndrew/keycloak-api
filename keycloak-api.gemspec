# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keycloak/version'

Gem::Specification.new do |spec|
  spec.name          = 'keycloak-api'
  spec.version       = Keycloak::VERSION
  spec.authors       = ['Andrew Ageev']
  spec.email         = ['ageev86@gmail.com']

  spec.summary       = 'Keycloak REST API Client for Ruby Application'
  spec.description   = 'Keycloak REST API Client for Ruby Application'
  spec.homepage      = 'https://github.com/AndrewAgeev/keycloak-api'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://github.com/AndrewAgeev/keycloak-api'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/AndrewAgeev/keycloak-api'
  spec.metadata['changelog_uri'] = 'https://github.com/AndrewAgeev/keycloak-api/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'awrence', '~> 1.1'
  spec.add_dependency 'plissken', '~> 1.3'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
