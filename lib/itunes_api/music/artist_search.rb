module ItunesApi
  module Music
    # Artists or Bands resulting from a search
    class ArtistSearch
      attr_reader_init :name, :store
      selfie :artists

      def artists
        @artists ||= artist_ids.map { |id| build_artist(id) }.compact
      end

      private

      def artist_ids
        @search ||= ItunesApi.artist_ids(name, store)
      end

      def build_artist(id)
        if (lookup = lookup(id))
          Artist.new(lookup, store)
        end
      end

      def lookup(id)
        Requests::Lookup.artist_with_albums(id, store)
      rescue
        nil
      end
    end
  end
end
