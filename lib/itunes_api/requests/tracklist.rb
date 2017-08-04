module ItunesApi
  module Requests
    # Allows querying the API via lookup for album songs.
    class Tracklist
      include Base
      attr_reader_init :album_id, :store
      selfie :attributes

      def attributes
        songs_data.map do |song_data|
          {
            duration: track_lenght(song_data[:trackTimeMillis]),
            name: song_data[:trackName],
            number: song_data[:trackNumber],
            streamable: song_data[:isStreamable],
          }
        end
      end

      private

      def action
        'lookup'
      end

      def query
        {
          entity: 'song',
          id: album_id,
          country: store.to_s.upcase,
          limit: LIMIT,
          sort: 'trackNumber'
        }
      end

      def songs_data
        songs_results.map { |song| symbolize_keys(song) }
      end

      def songs_results
        results.find_all { |wrappers| wrappers['wrapperType'] == 'track' }
      end

      def track_lenght(milliseconds)
        minutes, milliseconds = milliseconds.divmod(1000 * 60)
        seconds = milliseconds / 1000
        "#{minutes}:#{seconds}"
      end
    end
  end
end
