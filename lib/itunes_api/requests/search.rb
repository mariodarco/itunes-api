module ItunesApi
  module Requests
    # Fetch all the artist ids corresponding to a search term
    class Search
      include Base
      attr_reader_init :artist_name
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
          country: country_code,
          limit: LIMIT,
          media: 'music',
          sort: 'recent'
        }
      end
    end
  end
end
