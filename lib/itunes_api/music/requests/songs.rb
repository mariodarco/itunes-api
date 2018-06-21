# frozen_string_literal: true

module ItunesApi
  module Music
    module Requests
      # Allows querying the API via lookup for album songs.
      class Songs
        include Request
        attr_reader_init :search_id, :store
        selfie :find_by_id

        def find_by_id
          unwrapped_results(:track).map do |result|
            Results::Song.new(result, store)
          end
        end

        private

        def action
          'lookup'
        end

        def query
          {
            country: store.to_s.upcase,
            entity: :song,
            id: search_id,
            limit: LIMIT,
            sort: :trackNumber
          }
        end
      end
    end
  end
end
