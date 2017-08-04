require 'selfies'
require 'itunes_api/configuration'
require 'itunes_api/requests/all'
require 'itunes_api/music/all'

# Interface to the Itunes Api
module ItunesApi
  BASE_URL = 'https://itunes.apple.com'.freeze
  LIMIT = 200

  def self.artist_ids(name, store = default_store)
    Requests::Search.artist_ids(name, store)
  end

  def self.artist_data(name, store = default_store)
    Requests::Search.artist_data(name, store)
  end

  def self.all_artists_by_name(name, store = default_store)
    Music::Artist.search(name, store)
  end

  def self.artist_lookup(apple_id, store = default_store)
    Music::Artist.find_by_apple_id(apple_id, store)
  end

  def self.configure
    yield(Configuration.instance)
  end

  def self.default_store
    ItunesApi::Configuration.instance.country_code || :gb
  end
end
