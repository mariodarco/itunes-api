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

  def self.artist_lookup(artist_id, store = default_store)
    Music::ArtistLookup.artist(artist_id, store)
  end

  def self.artist_search(name, store = default_store)
    Music::ArtistSearch.artists(name, store)
  end

  def self.configure
    yield(Configuration.instance)
  end

  private

  def self.default_store
    Configuration.instance.country_code rescue :gb
  end
end
