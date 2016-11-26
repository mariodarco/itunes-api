require 'open-uri'
require 'json'

module ItunesApi
  # Allow requests to the iTunes API.
  module Request

    def response
      JSON.parse(request)
    end

    private

    def request
      @request ||= open(url).read
    end

    def query
      Addressable::URI.new(
        query_values: query_values
      ).query
    end

    def query_values
      {
        country: COUNTRY_CODE,
        limit: LIMIT,
        media: 'music'
      }
    end

    def results
      response.fetch('results', [])
    end

    def url
      "#{BASE_URL}/search?#{query}"
    end
  end
end
