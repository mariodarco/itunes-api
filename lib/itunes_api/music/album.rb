require 'date'
module ItunesApi
  module Music
    # Wrapper for album results.
    class Album
      attr_reader_init :artwork, :collection_id, :genre, :name, :release_on, :store

      def self.for_artist(apple_id, store)
        lookup(apple_id, store).map { |album_data| new(*album_data.values) }
      end

      def availability
        return @availability if @availability

        prefix = pre_release? ? 'pre_release_' : ''
        suffix = apple_music? ? 'streaming' : 'sale'
        @availability = "#{prefix}#{suffix}".to_sym
      end

      def to_hash
        {
          artwork: artwork,
          collection_id: collection_id,
          name: name,
          release_on: release_on,
          availability: availability,
          store: store
        }
      end

      def tracklist
        @tracklist ||= songs_data.map { |song_data| Track.new(*song_data.values) }
      end

      private

      def apple_music?
        tracklist.any?(&:streamable?)
      end

      def self.lookup(apple_id, store)
        Requests::Albums.attributes(apple_id, store)
      end

      def pre_release?
        release_on > Date.today
      end

      def songs_data
        @songs ||= Requests::Tracklist.attributes(collection_id, store)
      end
    end
  end
end
