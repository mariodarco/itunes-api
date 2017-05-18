require 'itunes_api/requests/base'
require 'itunes_api/requests/lookup'
require 'itunes_api/requests/search'
require 'itunes_api/music/album'
require 'itunes_api/music/artist'
require 'itunes_api/music/artist_search'

# Interface to the Itunes Api
module ItunesApi
  BASE_URL = 'https://itunes.apple.com'.freeze
  COUNTRY_CODE = 'GB'.freeze
  LIMIT = 200

  def self.artist_ids(name)
    Requests::Search.artist_ids(name)
  end

  def self.artist_search(name)
    Music::ArtistSearch.artists(name)
  end
end
