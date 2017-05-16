module ItunesApi
  module Music
    class Album
      attr_reader :name, :artwork, :released

      def initialize(data)
        @name = data['collectionName']
        @artwork = data['artworkUrl100']
        @released = Date.parse(data['releaseDate'])
      end

      def self.build(albums_data)
        albums_data.map { |data| new(data) }
      end
    end
  end
end
