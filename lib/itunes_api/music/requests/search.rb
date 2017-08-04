module ItunesApi
  module Music
    module Requests
      # Allows querying the API via search for artists.
      class Search
        include Request
        attr_reader_init :artist_name, :store
        selfie :artists

        def artists
          @artists ||= decorated_results.find_all(&:relevant?)
        end

        private

        def action
          'search'
        end

        def decorated_results
          results.map do |result|
            Results::Artist.new(result, store, artist_name)
          end
        end

        def query
          {
            attribute: 'artistTerm',
            country: store.to_s.upcase,
            entity: 'musicArtist',
            limit: LIMIT,
            media: 'music',
            term: artist_name
          }
        end
      end
    end
  end
end
