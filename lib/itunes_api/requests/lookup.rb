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
        artist.merge(albums: albums)
      end

      private

      def action
        'lookup'
      end

      def albums
        albums_data.map do |album|
          symbolize_keys(unwrapped(album))
        end
      end

      def albums_data
        results.find_all { |wrappers| wrappers['wrapperType'] == 'collection' }
      end

      def artist
        symbolize_keys(unwrapped(artist_data))
      end

      def artist_data
        symbolize_keys(
          unwrapped(
            results.find do |wrappers|
              wrappers['wrapperType'] == 'artist'
            end
          )
        )
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

      def unwrapped(hash)
        hash.delete('wrapperType')
        hash
      end
    end
  end
end
