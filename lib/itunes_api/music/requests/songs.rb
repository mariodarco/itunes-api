module ItunesApi
  module Music
    module Requests
      # Allows querying the API via lookup for album songs.
      class Songs
        include Request
        attr_reader_init :collection_id, :store
        selfie :find_by_collection_id

        def find_by_collection_id
          unwrapped_results.map do |result|
            Results::Song.new(result)
          end
        end

        private

        def action
          'lookup'
        end

        def query
          {
            entity: 'song',
            id: collection_id,
            country: store.to_s.upcase,
            limit: LIMIT,
            sort: 'trackNumber'
          }
        end

        def unwrapped_results
          return [] unless results.any?

          results.find_all do |wrappers|
            wrappers['wrapperType'] == 'track'
          end
        end
      end
    end
  end
end
