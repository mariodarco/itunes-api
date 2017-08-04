module ItunesApi
  module Music
    module Results
      # Wrapper for song search results.
      class Song
        attr_reader_init :data
        private :data

        def duration
          @duration ||= track_lenght(data['trackTimeMillis'])
        end

        def attributes
          [duration, name, number, streamable]
        end

        def name
          @name ||= data['trackName']
        end

        def number
          @number ||= data['trackNumber']
        end

        def streamable
          @streamable ||= data['isStreamable']
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
end
