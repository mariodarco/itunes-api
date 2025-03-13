# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itunes_api/version'

Gem::Specification.new do |spec|
  spec.name                  = 'itunes_api'
  spec.version               = ItunesApi::VERSION
  spec.authors               = ['Mario D’Arco']
  spec.email                 = ['mario.darco@hey.com']
  spec.summary               = 'iTunes Api'
  spec.description           = 'An interface to the iTunes Api'
  spec.homepage              = 'https://github.com/mariodarco/itunes-api'
  spec.license               = 'MIT'
  spec.bindir                = 'exe'
  spec.executables           = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.1'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.add_dependency 'faraday'
  spec.add_dependency 'selfies'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
end
