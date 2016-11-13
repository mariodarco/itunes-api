module ItunesApi
  module Music
    # Use to retrieve available albums from artist's ids.
    class Album
      include Request

      TYPE = 'Album'.freeze

      def initialize(artists_id)
        @artists_id = artists_id
      end

      def self.info(artists_id)
        new(artists_id).info
      end

      def info
        @info ||= results
                  .find_all { |r| r['collectionType'] == TYPE }
                  .sort_by { |a| a['releaseDate'] }
                  .reverse
      end

      private

      def url
        "#{BASE_URL}/lookup?id=#{all_artists_id}&" \
        "entity=#{entity}&country=#{COUNTRY_CODE}"
      end

      def all_artists_id
        @artists_id.join(',')
      end

      def entity
        TYPE.downcase
      end
    end
  end
end
