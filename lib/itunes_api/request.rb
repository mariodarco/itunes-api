require 'open-uri'
require 'json'

module ItunesApi
  # Allow requests to the iTunes API.
  module Request
    def request
      @request ||= open(url).read
    end

    def response
      JSON.parse(request)
    end

    def results
      response.fetch('results', [])
    end
  end
end
