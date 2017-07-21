module ItunesApi
  module Music
    # Wrapper for song results.
    class Track
      attr_reader_init :data
      private :data

      def self.build(songs_data)
        songs_data.map { |data| new(data) }
      end

      def duration
        @duration ||= track_lenght(data[:trackTimeMillis])
      end

      def name
        @name ||= data[:trackName]
      end

      def number
        data[:trackNumber]
      end

      def streamable?
        data[:isStreamable]
      end

      def to_hash
        {
          duration: duration,
          name: name,
          number: number,
          stremable: stremable?,
        }
      end

      private

      def track_lenght(milliseconds)
        minutes, milliseconds = milliseconds.divmod(1000 * 60)
        seconds = milliseconds / 1000
        "#{minutes}:#{seconds}"
      end
    end
  end
end
