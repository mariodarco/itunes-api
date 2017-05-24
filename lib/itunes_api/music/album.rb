module ItunesApi
  module Music
    # Wrapper for album results.
    class Album
      def initialize(data)
        @data = data
      end

      def self.build(albums_data)
        albums_data.map { |data| new(data) }
                   .sort_by(&:released)
                   .reverse
      end

      def artwork
        @artwork ||= data[:artworkUrl100]
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
        }
      end

      private

      attr_reader :data
    end
  end
end
