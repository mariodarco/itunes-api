require 'date'
module ItunesApi
  module Music
    # Wrapper for album results.
    class Album
      attr_reader_init :artwork, :collection_id, :genre, :name, :release_on, :store

      class << self
        def for_artist(apple_id, store)
          albums(apple_id, store).map { |album| new(*album.attributes) }
        end

        private

        def albums(apple_id, store)
          Requests::Albums.find_by_apple_id(apple_id, store)
        end
      end

      def availability
        @availability ||= build_availability
      end

      def to_hash
        {
          artwork: artwork,
          availability: availability,
          collection_id: collection_id,
          name: name,
          release_on: release_on,
          store: store
        }
      end

      def tracklist
        @tracklist ||= songs.map { |song| Song.new(*song.attributes) }
      end

      private

      def apple_music?
        tracklist.any?(&:streamable?)
      end

      def build_availability
        prefix = pre_release? ? 'pre_release_' : ''
        suffix = apple_music? ? 'streaming' : 'sale'
        "#{prefix}#{suffix}".to_sym
      end

      def pre_release?
        release_on > Date.today
      end

      def songs
        @songs ||= Requests::Songs.find_by_collection_id(collection_id, store)
      end
    end
  end
end
