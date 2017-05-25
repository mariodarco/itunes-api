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
        @artists ||= artist_ids.map { |id| build_artist(id) }.compact
      end

      private

      attr_reader :name

      def artist_ids
        @search ||= ItunesApi.artist_ids(name)
      end

      def build_artist(id)
        if (lookup = lookup(id))
          Artist.new(lookup)
        end
      end

      def lookup(id)
        Requests::Lookup.artist_with_albums(id)
      rescue
        nil
      end
    end
  end
end
