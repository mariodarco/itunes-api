module ItunesApi
  module Music
    module Requests
      # Allows querying the API via lookup for albums.
      class Albums
        include Request
        attr_reader_init :apple_id, :store
        selfie :find_by_apple_id

        def find_by_apple_id
          unwrapped_results.map do |result|
            Results::Album.new(result, store)
          end
        end

        private

        def action
          'lookup'
        end

        def query
          {
            id: apple_id,
            country: store.to_s.upcase,
            entity: :album,
            limit: LIMIT
          }
        end

        def unwrapped_results
          return [] unless results.any?

          results.find_all do |wrappers|
            wrappers['wrapperType'] == 'collection'
          end
        end
      end
    end
  end
end
