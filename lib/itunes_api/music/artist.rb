require 'addressable/uri'

module ItunesApi
  module Music
    # Retrieve apple ids and albums of artists.
    class Artist
      include Request

      def initialize(artist_name, apple_id = nil)
        @artist_name = artist_name
        @apple_id = normalize(apple_id.to_i)
      end

      def albums
        @albums ||= filtered_results
                    .sort_by { |result| result['releaseDate'] }
                    .reverse
                    .map { |info| Album.new(info) }
      end

      def apple_ids
        return [@apple_id] if @apple_id

        @apple_ids ||= filtered_albums.collect do |album|
          album['artistId']
        end.compact.uniq.sort
      end

      private

      def filtered_albums
        results.find_all { |result| result['collectionType'] == 'Album' }
      end

      def filtered_results
        filtered_albums.find_all do |album|
          (!@apple_id || album['artistId'] == @apple_id)
        end
      end

      def normalize(apple_id)
        apple_id.zero? ? nil : apple_id
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
