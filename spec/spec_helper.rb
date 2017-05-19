$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'itunes_api'
require 'vcr'

VCR.configure do |c|
  c.hook_into Faraday
  c.cassette_library_dir = 'spec/cassettes'
end
