module ItunesApi
  module Requests
    # Fetch all the artist ids corresponding to a search term
    class Search
      include Base
      attr_reader_init :artist_name, :store
      selfie :artist_ids

      def artist_ids
        results.collect do |result|
          result['artistId']
        end.compact.uniq.sort
      end

      private

      def action
        'search'
      end

      def query
        {
          attribute: 'artistTerm',
          entity: 'album',
          term: @artist_name,
          country: store.to_s.upcase,
          limit: LIMIT,
          media: 'music',
          sort: 'recent'
        }
      end
    end
  end
end
