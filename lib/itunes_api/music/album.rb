module ItunesApi
  module Music
    # Retrieves album tracks info.
    class Album
      attr_accessor :name
      include Request

      def initialize(name, filtering_options = {})
        @name = name
        @filtering_options = filtering_options
      end

      def tracks
        @tracks ||= filtered_results.sort_by { |track| track['trackNumber'] }
      end

      def apple_music?
        tracks.any? { |track| track['isStreamable'] }
      end

      private

      def album_id
        @album_id ||= @filtering_options[:album_id]
      end

      def artist_id
        @artist_id ||= @filtering_options[:artist_id]
      end

      def filtered_results
        @filtered_results ||= results.find_all do |result|
          (!album_id || result['collectionId'] == album_id) &&
            (!artist_id || result['artistId'] == artist_id)
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
