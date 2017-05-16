module ItunesApi
  module Music
    # Artist or Band from the Apple catalog
    class Artist
      attr_reader :name, :artist_id, :albums

      def initialize(data)
        @name = data['artistName']
        @artist_id = data['amgArtistId']
        @albums = Album.build(data[:albums])
      end
    end
  end
end
