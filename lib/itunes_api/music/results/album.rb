module ItunesApi
  module Music
    module Results
      # Wrapper for album search results.
      class Album
        attr_reader_init :data, :store
        private :data

        def artwork
          @artwork ||= data['artworkUrl100']
        end

        def attributes
          [artwork, collection_id, genre, name, release_on, store]
        end

        def collection_id
          @collection_id ||= data['collectionId']
        end

        def genre
          @genre ||= data['primaryGenreName']
        end

        def name
          @name ||= data['collectionName']
        end

        def release_on
          @release_on ||= Date.parse(data['releaseDate'])
        end
      end
    end
  end
end
