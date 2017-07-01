require 'selfies'
require 'itunes_api/configuration'
require 'itunes_api/requests/all'
require 'itunes_api/music/all'

# Interface to the Itunes Api
module ItunesApi
  BASE_URL = 'https://itunes.apple.com'.freeze
  LIMIT = 200

  def self.artist_ids(name)
    Requests::Search.artist_ids(name)
  end

  def self.artist_lookup(artist_id)
    Music::ArtistLookup.artist(artist_id)
  end

  def self.artist_search(name)
    Music::ArtistSearch.artists(name)
  end

  def self.configure
    yield(Configuration.instance)
  end
end
