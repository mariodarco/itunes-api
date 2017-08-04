module ItunesApi
  module Requests
    # Allows querying the API via lookup for artists.
    class Artist
      include Base
      attr_reader_init :apple_id, :store
      selfie :attributes

      def attributes
        return artist_data unless artist_data

        {
          apple_id: artist_data[:artistId],
          genre: artist_data[:primaryGenreName],
          name: artist_data[:artistName],
          store: store
        }
      end

      private

      def action
        'lookup'
      end

      def artist_data
        return nil unless results.any?

        symbolize_keys(results.first)
      end

      def query
        {
          id: apple_id,
          country: store.to_s.upcase,
          limit: LIMIT
        }
      end
    end
  end
end
