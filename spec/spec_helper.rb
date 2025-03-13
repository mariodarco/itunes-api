# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'itunes_api'
require 'vcr'

VCR.configure do |c|
  c.hook_into :faraday
  c.cassette_library_dir = 'spec/cassettes'
end
