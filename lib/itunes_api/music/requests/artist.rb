# frozen_string_literal: true

module ItunesApi
  module Music
    module Requests
      # Allows querying the API via lookup for artists.
      class Artist
        include Request
        attr_reader_init :search_id, :store
        selfie :find_by_id

        def find_by_id
          unwrapped_results(:artist).map do |result|
            Results::Artist.new(result, store)
          end
        end

        private

        def action
          'lookup'
        end

        def query
          {
            id: search_id,
            country: store.to_s.upcase,
            limit: LIMIT
          }
        end
      end
    end
  end
end
