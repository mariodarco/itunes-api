# frozen_string_literal: true

require 'singleton'

module ItunesApi
  # Used to hold configurations
  class Configuration
    include Singleton
    attr_accessor :country_code
  end
end
