module ItunesApi
  module Music
    # Artists or Bands resulting from a search
    class ArtistSearch
      def initialize(name)
        @name = name
      end

      def self.artists(name)
        new(name).artists
      end

      def artists
        @artists ||= artist_ids.map { |id| build_artist(id) }
      end

      private

      def artist_ids
        @search ||= ItunesApi.artist_ids(@name)
      end

      def build_artist(id)
        Artist.new(
          Requests::Lookup.artist_with_albums(id)
        )
      end
    end
  end
end
