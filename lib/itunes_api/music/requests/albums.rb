module ItunesApi
  module Music
    module Requests
      # Allows querying the API via lookup for albums.
      class Albums
        include Request
        attr_reader_init :search_id, :store
        selfie :find_by_id

        def find_by_id
          unwrapped_results(:collection).map do |result|
            Results::Album.new(result, store)
          end
        end

        private

        def action
          'lookup'
        end

        def query
          {
            country: store.to_s.upcase,
            entity: :album,
            id: search_id,
            limit: LIMIT
          }
        end
      end
    end
  end
end
