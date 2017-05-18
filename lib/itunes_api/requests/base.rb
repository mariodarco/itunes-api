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

      def symbolize_keys(hash)
        hash.each_with_object({}) do |(key, value), new_hash|
          new_hash[key.to_sym] = value
          new_hash
        end
      end

      def url
        "#{BASE_URL}/#{action}?#{query}"
      end
    end
  end
end
