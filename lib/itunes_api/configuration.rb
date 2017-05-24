require 'singleton'

module ItunesApi
  class Configuration
    include Singleton
    attr_accessor :country_code
  end
end
