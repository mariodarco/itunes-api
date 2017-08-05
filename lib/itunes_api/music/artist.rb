module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      attr_reader_init :amg_id, :apple_id, :genre, :link, :name, :store

      class << self
        def all_apple_ids(name, store)
          find_all_by_name(name, store).map(&:apple_id)
        end

        def find_all_by_name(name, store)
          Requests::Search.artists(name, store).map do |result|
            new(*result.attributes)
          end
        end

        def find_by_apple_id(apple_id, store)
          artist = artist(apple_id, store)
          artist ? new(*artist.attributes) : nil
        end

        private

        def artist(apple_id, store)
          Requests::Artist.find_by_apple_id(apple_id, store)
        end
      end

      def albums
        @albums ||= Album.for_artist(apple_id, store)
      end

      def to_hash
        {
          amg_id: amg_id,
          apple_id: apple_id,
          genre: genre,
          link: link,
          name: name,
          store: store
        }
      end
    end
  end
end
