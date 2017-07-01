module ItunesApi
  module Music
    # Artist or Band resulting from a specific lookup
    class ArtistLookup
      attr_reader_init :artist_id
      selfie :artist

      def artist
        build_artist
      end

      private

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
