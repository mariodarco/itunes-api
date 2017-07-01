module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      attr_reader_init :data
      private :data

      def albums
        @albums ||= Album.build(data[:albums])
      end

      def apple_id
        @apple_id ||= data[:artistId]
      end

      def name
        @name ||= data[:artistName]
      end
    end
  end
end
