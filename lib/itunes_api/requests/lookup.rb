module ItunesApi
  module Requests
    # Allows querying the API via lookup.
    class Lookup
      include Base

      def initialize(artist_id)
        @artist_id = artist_id
      end

      def self.artist_with_albums(id)
        new(id).artist_with_albums
      end

      def artist_with_albums
        artist_data.merge({ albums: albums_data })
      end

      private

      def albums_data
        results.find_all { |wrappers| wrappers['wrapperType'] == 'collection' }
      end

      def artist_data
        results.find { |wrappers| wrappers['wrapperType'] == 'artist' }
      end

      def action
        'lookup'
      end

      def query_values
        {
          entity: 'album',
          amgArtistId: @artist_id,
          country: COUNTRY_CODE,
          limit: LIMIT,
          sort: 'recent'
        }
      end
    end
  end
end
