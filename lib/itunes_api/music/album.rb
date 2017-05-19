module ItunesApi
  module Music
    # Wrapper for album results.
    class Album
      def initialize(data)
        @data = data
      end

      def self.build(albums_data)
        albums_data.map { |data| new(data) }
      end

      def artwork
        @artwork ||= data['artworkUrl100']
      end

      def name
        @name ||= data['collectionName']
      end

      def released
        @released ||= Date.parse(data['releaseDate'])
      end

      private

      attr_reader :data
    end
  end
end
