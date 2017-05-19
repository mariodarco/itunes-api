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
        @artist ||= build_artist(artist_id)
      end

      private

      attr_reader :artist_id

      def build_artist(id)
        Artist.new(
          Requests::Lookup.artist_with_albums(id)
        )
      end
    end
  end
end
