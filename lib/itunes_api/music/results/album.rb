# frozen_string_literal: true

module ItunesApi
  module Music
    module Results
      # Wrapper for album search results.
      class Album
        attr_reader_init :data, :store

        def artist
          @artist ||= data['artistName']
        end

        def artwork
          @artwork ||= data['artworkUrl100']
        end

        def attributes
          [
            artist,
            artwork,
            collection_id,
            explicitness,
            genre,
            link,
            name,
            release_on,
            store,
            track_count
          ]
        end

        def collection_id
          @collection_id ||= data['collectionId']
        end

        def explicitness
          @explicitness ||= data['collectionExplicitness']
        end

        def genre
          @genre ||= data['primaryGenreName']
        end

        def link
          @link ||= data['collectionViewUrl']
        end

        def name
          @name ||= data['collectionName']
        end

        def release_on
          @release_on ||= Date.parse(data['releaseDate'])
        end

        def track_count
          @track_count ||= data['trackCount']
        end
      end
    end
  end
end
