module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      attr_reader_init :apple_id, :genre, :name, :store

      def self.find_by_apple_id(apple_id, store)
        new(*lookup(apple_id, store))
      end

      def self.search(name, store)
        Requests::Search.artist_data(name, store).map do |artist_data|
          new(*artist_data.values)
        end
      end

      def albums
        @albums ||= Album.for_artist(apple_id, store)
      end

      def to_hash
        {
          apple_id: apple_id,
          name: name,
          store: store
        }
      end

      def self.lookup(apple_id, store)
        Requests::Artist.attributes(apple_id, store).values
      end
    end
  end
end
