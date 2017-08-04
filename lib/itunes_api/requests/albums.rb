module ItunesApi
  module Requests
    # Allows querying the API via lookup for albums.
    class Albums
      include Base
      attr_reader_init :apple_id, :store
      selfie :attributes

      def attributes
        albums_data.map do |album_data|
          {
            artwork: album_data[:artworkUrl100],
            collection_id: album_data[:collectionId],
            genre: album_data[:primaryGenreName],
            name: album_data[:collectionName],
            release_on: Date.parse(album_data[:releaseDate]),
            store: store
          }
        end
      end

      private

      def action
        'lookup'
      end

      def albums_data
        return nil unless results.any?

        unwrapped_results.map do |album_data|
          symbolize_keys(album_data)
        end
      end

      def query
        {
          id: apple_id,
          country: store.to_s.upcase,
          entity: :album,
          limit: LIMIT
        }
      end

      def unwrapped_results
        return [] unless results.any?

        results.find_all do |wrappers|
          wrappers['wrapperType'] == 'collection'
        end
      end
    end
  end
end
