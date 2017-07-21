module ItunesApi
  module Requests
    # Allows querying the API via lookup for album songs.
    class AlbumTracklist
      include Base
      attr_reader_init :album_id, :store
      selfie :songs

      def songs
        songs_data.map do |song|
          symbolize_keys(unwrapped(song))
        end
      end

      private

      def action
        'lookup'
      end

      def songs_data
        results.find_all { |wrappers| wrappers['wrapperType'] == 'track' }
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
    end
  end
end
