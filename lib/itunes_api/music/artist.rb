require 'addressable/uri'

module ItunesApi
  module Music
    # Use to retrieve artist ids from their names.
    class Artist
      include Request

      def initialize(artist_name)
        @artist_name = artist_name
      end

      def self.apple_ids(artist_name)
        new(artist_name).apple_ids
      end

      def apple_ids
        results.collect{ |r| r['artistId'] }.compact.uniq.sort
      end

      private

      def url
        "#{BASE_URL}/search?#{query}"
      end

      def query
        Addressable::URI.new(
          query_values: { term: @artist_name }
        ).query
      end
    end
  end
end
