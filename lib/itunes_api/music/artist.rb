module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      def initialize(data)
        @data = data
      end

      def albums
        @albums ||= Album.build(data[:albums])
      end

      def artist_id
        @artist_id ||= data['amgArtistId']
      end

      def name
        @name ||= data['artistName']
      end

      private

      attr_reader :data
    end
  end
end
