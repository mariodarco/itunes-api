require 'faraday'
require 'json'
module ItunesApi
  # Allow requests to the iTunes API.
  module Request
    def results
      @results ||= parsed_response.fetch('results') { [] }
    end

    private

    def connection
      Faraday.new(url: BASE_URL)
    end

    def parsed_response
      JSON.parse(response.body)
    end

    def response
      connection.get(action, query)
    end

    def unwrapped_results(type)
      return [] unless results.any?

      results.find_all do |wrappers|
        wrappers['wrapperType'] == type.to_s
      end
    end
  end
end
