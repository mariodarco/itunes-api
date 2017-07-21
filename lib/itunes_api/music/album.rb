require 'date'
module ItunesApi
  module Music
    # Wrapper for album results.
    class Album
      attr_reader_init :data, :store
      private :data

      def self.build(albums_data, store)
        albums_data.map { |data| new(data, store) }
                   .sort_by(&:released)
                   .reverse
      end

      def artwork
        @artwork ||= data[:artworkUrl100]
      end

      def availability
        return :streaming if apple_music?

        :sale
      end

      def collection_id
        @collection_id ||= data[:collectionId]
      end

      def name
        @name ||= data[:collectionName]
      end

      def released
        @released ||= Date.parse(data[:releaseDate])
      end

      def to_hash
        {
          artwork: artwork,
          collection_id: collection_id,
          name: name,
          released: released,
          availability: availability
        }
      end

      private

      def apple_music?
        tracklist.any?(&:streamable?)
      end

      def tracklist
        @tracklist ||= AlbumLookup.tracklist(collection_id, store)
      end
    end
  end
end
