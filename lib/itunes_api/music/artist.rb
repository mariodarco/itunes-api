# frozen_string_literal: true

module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      attr_reader_init :amg_id, :apple_id, :genre, :link, :name, :store

      class << self
        def find_by_name(name, store)
          Requests::Search.artists(name, store).map do |result|
            new(*result.attributes)
          end
        end

        def find_by_apple_id(apple_id, store)
          result = artists(apple_id, store).first

          new(*result.attributes) if result
        end

        private

        def artists(id, store)
          Requests::Artist.find_by_id(id, store)
        end
      end

      def albums
        @albums ||= Album.find_by_apple_id(apple_id, store)
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
