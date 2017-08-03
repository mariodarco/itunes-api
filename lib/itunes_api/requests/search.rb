module ItunesApi
  module Requests
    # Fetch all the artist ids corresponding to a search term
    class Search
      include Base
      attr_reader_init :artist_name, :store
      selfie :artist_ids

      def artist_ids
        results.collect { |result| result['artistId'] }.compact.uniq
      end

      private

      def action
        'search'
      end

      def query
        {
          attribute: 'artistTerm',
          entity: 'musicArtist',
          term: artist_name,
          country: store.to_s.upcase,
          limit: LIMIT,
          media: 'music',
          sort: 'recent'
        }
      end
    end
  end
end
