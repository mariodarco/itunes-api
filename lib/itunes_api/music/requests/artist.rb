module ItunesApi
  module Music
    module Requests
      # Allows querying the API via lookup for artists.
      class Artist
        include Request
        attr_reader_init :apple_id, :store
        selfie :find_by_apple_id

        def find_by_apple_id
          return nil unless results.any?

          Results::Artist.new(results.first, store)
        end

        private

        def action
          'lookup'
        end

        def query
          {
            id: apple_id,
            country: store.to_s.upcase,
            limit: LIMIT
          }
        end
      end
    end
  end
end
