module ItunesApi
  module Music
    # Retrieves album tracks info.
    class Album
      attr_accessor :name, :artwork, :track_count, :release_date
      include Request

      def initialize(info)
        @name = info['collectionName']
        @album_id = info['collectionId']
        @artwork = info['artworkUrl100']
        @track_count = info['trackCount']
        @release_date = Date.parse(info['releaseDate'])
      end

      def apple_music?
        streamable_tracks.any?
      end

      def streamable_tracks
        tracks.select { |track| track['isStreamable'] }
      end

      def tracks
        @tracks ||= filtered_results.sort_by { |track| track['trackNumber'] }
      end

      private

      def filtered_results
        @filtered_results ||= results.find_all do |result|
          result['collectionId'] == @album_id
        end
      end

      def query_values
        {
          attribute: 'albumTerm',
          entity: 'musicTrack',
          term: name
        }.merge(super)
      end
    end
  end
end
