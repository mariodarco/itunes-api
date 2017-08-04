module ItunesApi
  module Music
    # Wrapper for song results.
    class Song
      attr_reader_init :duration, :name, :number, :streamable
      alias streamable? streamable

      def to_hash
        {
          duration: duration,
          name: name,
          number: number,
          stremable: streamable?,
        }
      end
    end
  end
end
