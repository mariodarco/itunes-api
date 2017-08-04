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
      def all_apple_ids(name, store = default_store)
        Artist.all_apple_ids(name, store)
      end

      def all_artists_by_name(name, store = default_store)
        Artist.find_all_by_name(name, store)
      end

      def find_by_apple_id(apple_id, store = default_store)
        Music::Artist.find_by_apple_id(apple_id, store)
      end

      private

      def default_store
        ItunesApi::Configuration.instance.country_code || :gb
      end
    end
  end
end
