# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itunes_api/version'

Gem::Specification.new do |spec|
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  unless spec.respond_to?(:metadata)
    raise 'RubyGems 2.0 or newer is required to protect ' \
          'against public gem pushes.'
  end

  spec.name          = 'itunes_api'
  spec.version       = ItunesApi::VERSION
  spec.authors       = ['Mario D’Arco']
  spec.email         = ['mariodarco78@icloud.com']
  spec.summary       = 'iTunes Api'
  spec.description   = 'An interface to the iTunes Api'
  spec.homepage      = 'https://github.com/mariodarco/itunes-api'
  spec.license       = 'MIT'
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.45'
  spec.add_development_dependency 'addressable'
end
