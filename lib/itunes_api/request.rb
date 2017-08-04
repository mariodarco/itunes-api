require 'faraday'
require 'json'
module ItunesApi
  # Allow requests to the iTunes API.
  module Request
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
  end
end
