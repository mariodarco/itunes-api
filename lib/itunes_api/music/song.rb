module ItunesApi
  module Music
    # Wrapper for song results.
    class Song
      attr_reader_init :album,
                       :artist,
                       :duration,
                       :explicitness,
                       :genre,
                       :link,
                       :name,
                       :number,
                       :preview,
                       :store,
                       :streamable,
                       :track_id

      alias streamable? streamable

      class << self
        def find_by_collection_id(collection_id, store)
          songs(collection_id, store).map { |song| new(*song.attributes) }
        end

        def find_by_track_id(track_id, store)
          result = songs(track_id, store).first

          new(*result.attributes) if result
        end

        private

        def songs(id, store)
          Requests::Songs.find_by_id(id, store)
        end
      end

      def explicit?
        explicitness == 'explicit'
      end

      def to_hash
        {
          album: album,
          artist: artist,
          duration: duration,
          explicit: explicit?,
          genre: genre,
          link: link,
          name: name,
          number: number,
          preview: preview,
          store: store,
          streamable: streamable,
          track_id: track_id
        }
      end
    end
  end
end
