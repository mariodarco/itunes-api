# frozen_string_literal: true

require 'selfies'
require 'itunes_api/configuration'
require 'itunes_api/music'

# Interface to the Itunes Api
module ItunesApi
  BASE_URL = 'https://itunes.apple.com'
  LIMIT = 200

  def self.configure
    yield(Configuration.instance)
  end
end
