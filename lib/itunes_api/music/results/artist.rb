module ItunesApi
  module Music
    module Results
      # Wrapper for artist search results.
      class Artist
        attr_reader_init :data, :store, search_term: nil
        private :data, :search_term

        def amg_id
          @amg_id ||= data['amgArtistId']
        end

        def apple_id
          @apple_id ||= data['artistId']
        end

        def attributes
          [amg_id, apple_id, genre, link, name, store]
        end

        def genre
          @genre ||= data['primaryGenreName']
        end

        def link
          @link ||= data['artistLinkUrl']
        end

        def name
          @name ||= data['artistName']
        end

        def relevant?
          return true unless search_term

          name.downcase.include?(search_term.downcase)
        end
      end
    end
  end
end
