require 'addressable/uri'
module ItunesApi
  module Requests
    # Fetch all the artist ids corresponding to a search term
    class Search
      include Base

      def initialize(artist_name)
        @artist_name = artist_name
      end

      def self.artist_ids(artist_name)
        new(artist_name).artist_ids
      end

      def artist_ids
        results.collect do |result|
          result['amgArtistId']
        end.compact.uniq.sort
      end

      private

      def action
        'search'
      end

      def query_values
        {
          attribute: 'artistTerm',
          entity: 'album',
          term: @artist_name,
          country: COUNTRY_CODE,
          limit: LIMIT,
          media: 'music',
          sort: 'recent'
        }
      end
    end
  end
end
