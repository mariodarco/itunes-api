module ItunesApi
  module Requests
    # Allows querying the API via lookup.
    class Lookup
      include Base
      attr_reader_init :artist_id
      selfie :artist_with_albums

      def artist_with_albums
        return artist unless artist

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
        return artist_data unless artist_data

        symbolize_keys(unwrapped(artist_data))
      end

      def artist_data
        @artist_data ||= results.find do |wrappers|
          wrappers['wrapperType'] == 'artist'
        end
      end

      def query
        {
          entity: 'album',
          id: @artist_id,
          country: country_code,
          limit: LIMIT,
          sort: 'recent'
        }
      end

      def unwrapped(data_hash)
        data_hash.tap { |hash| hash.delete('wrapperType') }
      end
    end
  end
end
