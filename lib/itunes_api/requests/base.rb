require 'faraday'
require 'json'
module ItunesApi
  module Requests
    # Allow requests to the iTunes API.
    module Base
      def results
        @results ||= parsed_response.fetch('results') { [] }
      end

      private

      def parsed_response
        JSON.parse(response.body)
      end

      def connection
        Faraday.new(url: BASE_URL)
      end

      def response
        connection.get(action, query)
      end

      def symbolize_keys(hash)
        hash.each_with_object({}) do |(key, value), new_hash|
          new_hash[key.to_sym] = value
          new_hash
        end
      end

      # def url
      #   "#{BASE_URL}/#{action}?#{query}"
      # end
    end
  end
end
