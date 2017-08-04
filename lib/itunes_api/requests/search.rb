module ItunesApi
  module Requests
    # Allows querying the API via search for artists.
    class Search
      include Base
      attr_reader_init :artist_name, :store
      selfie :artist_ids, :artist_data

      def artist_ids
        artist_data.collect { |artist| artist[:apple_id] }
      end

      def artist_data
        results.collect do |result|
          if name_in?(result['artistName'])
            {
              apple_id: result['artistId'],
              genre: result['primaryGenreName'],
              name: result['artistName'],
              store: store
            }
          end
        end.compact.uniq
      end

      private

      def action
        'search'
      end

      def name_in?(complete_name)
        complete_name.downcase.include?(artist_name.downcase) ? true : nil
      end

      def query
        {
          attribute: 'artistTerm',
          entity: 'musicArtist',
          term: artist_name,
          country: store.to_s.upcase,
          limit: LIMIT,
          media: 'music',
        }
      end
    end
  end
end
