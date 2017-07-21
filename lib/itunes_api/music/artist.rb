module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      attr_reader_init :data, :store
      private :data

      def albums
        @albums ||= Album.build(data[:albums], store)
      end

      def apple_id
        @apple_id ||= data[:artistId]
      end

      def name
        @name ||= data[:artistName]
      end

      def to_hash
        {
          apple_id: apple_id,
          name: name,
          store: store
        }
      end
    end
  end
end
