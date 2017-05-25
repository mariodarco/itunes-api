module ItunesApi
  module Music
    # Artist or Band resulting from a specific lookup
    class ArtistLookup
      def initialize(artist_id)
        @artist_id = artist_id
      end

      def self.artist(artist_id)
        new(artist_id).artist
      end

      def artist
        build_artist
      end

      private

      attr_reader :artist_id

      def build_artist
        return lookup unless lookup

        Artist.new(lookup)
      end

      def lookup
        @lookup ||= Requests::Lookup.artist_with_albums(artist_id)
      end
    end
  end
end
