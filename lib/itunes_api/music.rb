require_relative 'request'
require_relative 'music/requests'
require_relative 'music/results'
require_relative 'music/album'
require_relative 'music/artist'
require_relative 'music/song'

module ItunesApi
  # Public interface for the Music Api
  module Music
    class << self
      def find_by_name(name, store = default_store)
        Artist.find_by_name(name, store)
      end

      def find_by_apple_id(apple_id, store = default_store)
        Music::Artist.find_by_apple_id(apple_id, store)
      end

      def find_albums_by_apple_id(apple_id, store = default_store)
        Music::Album.find_by_apple_id(apple_id, store)
      end

      def find_by_collection_id(collection_id, store = default_store)
        Music::Album.find_by_collection_id(collection_id, store)
      end

      def find_songs_by_collection_id(collection_id, store = default_store)
        Music::Song.find_by_collection_id(collection_id, store)
      end

      def find_by_track_id(track_id, store = default_store)
        Music::Song.find_by_track_id(track_id, store)
      end

      private

      def default_store
        ItunesApi::Configuration.instance.country_code || :gb
      end
    end
  end
end
