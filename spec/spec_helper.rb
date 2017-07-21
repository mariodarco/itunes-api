$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'itunes_api'
require 'vcr'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start
VCR.configure do |c|
  c.hook_into :faraday
  c.cassette_library_dir = 'spec/cassettes'
end
