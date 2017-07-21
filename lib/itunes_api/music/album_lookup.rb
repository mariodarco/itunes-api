module ItunesApi
  module Music
    # Album Tracklist resulting from a specific lookup
    class AlbumLookup
      attr_reader_init :album_id, :store
      selfie :tracklist

      def tracklist
        return [] unless songs_data

        Track.build(songs_data)
      end

      private

      def songs_data
        @songs_data ||= Requests::AlbumTracklist.songs(album_id, store)
      end
    end
  end
end
