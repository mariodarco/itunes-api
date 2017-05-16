require 'open-uri'
require 'json'
module ItunesApi
  module Requests
    # Allow requests to the iTunes API.
    module Base

      def results
        response.fetch('results') { [] }
      end

      private

      def query
        Addressable::URI.new(
          query_values: query_values
        ).query
      end

      def request
        open(url).read
      end

      def response
        @response ||= JSON.parse(request)
      end

      def url
        "#{BASE_URL}/#{action}?#{query}"
      end
    end
  end
end
