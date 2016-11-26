require 'addressable/uri'

module ItunesApi
  module Music
    # Retrieve apple ids and albums of artists.
    class Artist
      include Request

      def initialize(artist_name, apple_id = nil)
        @artist_name = artist_name
        @apple_id = apple_id
      end

      def albums(limit = 3)
        @albums ||= filtered_results
                    .sort_by { |result| result['releaseDate'] }
                    .reverse
                    .first(limit)
                    .map { |result| album(result) }
      end

      def apple_ids
        @apple_ids ||= filtered_results.collect do |album|
          album['artistId']
        end.compact.uniq.sort
      end

      private

      def filtered_results
        results.find_all do |result|
          result['collectionType'] == 'Album' &&
            (!@apple_id || result['artistId'] == @apple_id)
        end
      end

      def album(result)
        Album.new(
          result['collectionName'],
          {
            artist_id: @apple_id,
            album_id: result['collectionId']
          }
        )
      end

      def query_values
        {
          attribute: 'artistTerm',
          entity: 'album',
          term: @artist_name
        }.merge(super)
      end
    end
  end
end
