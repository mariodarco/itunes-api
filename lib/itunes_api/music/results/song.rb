# frozen_string_literal: true

module ItunesApi
  module Music
    module Results
      # Wrapper for song search results.
      class Song
        attr_reader_init :data, :store

        def album
          @album ||= data['collectionName']
        end

        def artist
          @artist ||= data['artistName']
        end

        def attributes
          [
            album,
            artist,
            duration,
            explicitness,
            genre,
            link,
            name,
            number,
            preview,
            store,
            streamable,
            track_id
          ]
        end

        def duration
          @duration ||= track_lenght(data['trackTimeMillis'])
        end

        def explicitness
          @explicitness ||= data['trackExplicitness']
        end

        def genre
          @genre ||= data['primaryGenreName']
        end

        def link
          @link ||= data['trackViewUrl']
        end

        def name
          @name ||= data['trackName']
        end

        def number
          @number ||= data['trackNumber']
        end

        def preview
          @preview ||= data['previewUrl']
        end

        def streamable
          @streamable ||= data['isStreamable']
        end

        def track_id
          @track_id ||= data['trackId']
        end

        private

        def track_lenght(milliseconds)
          if milliseconds.to_i.positive?
            minutes, milliseconds = milliseconds.divmod(1000 * 60)
            seconds = milliseconds / 1000
            "#{minutes}:#{seconds}"
          else
            '-:--'
          end
        end
      end
    end
  end
end
