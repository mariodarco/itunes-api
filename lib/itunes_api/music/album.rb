require 'date'
module ItunesApi
  module Music
    # Wrapper for album results.
    class Album
      attr_reader_init :artist,
                       :artwork,
                       :collection_id,
                       :explicitness,
                       :genre,
                       :link,
                       :name,
                       :release_on,
                       :store,
                       :track_count

      class << self
        def find_by_collection_id(collection_id, store)
          result = albums(collection_id, store).first

          new(*result.attributes) if result
        end

        def find_by_apple_id(apple_id, store)
          albums(apple_id, store).map { |album| new(*album.attributes) }
        end

        private

        def albums(id, store)
          Requests::Albums.find_by_id(id, store)
        end
      end

      def availability
        @availability ||= build_availability
      end

      def explicit?
        explicitness == 'explicit'
      end

      def to_hash
        {
          artist: artist,
          artwork: artwork,
          availability: availability,
          collection_id: collection_id,
          explicit: explicit?,
          genre: genre,
          link: link,
          name: name,
          release_on: release_on,
          store: store,
          track_count: track_count
        }
      end

      def tracklist
        @tracklist ||= Song.find_by_collection_id(collection_id, store)
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
    end
  end
end
