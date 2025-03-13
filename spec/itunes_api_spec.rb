# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi do
  it 'has a base url' do
    expect(ItunesApi::BASE_URL).to eql 'https://itunes.apple.com'
  end

  it 'has a limit' do
    expect(ItunesApi::LIMIT).to be 200
  end

  it 'has a version' do
    expect(ItunesApi::VERSION).not_to be_nil
  end

  describe '.configure' do
    let(:country_code) { ItunesApi::Configuration.instance.country_code }

    before do
      described_class.configure do |config|
        config.country_code = :it
      end
    end

    it 'yields a configuration instance with given settings' do
      expect(country_code).to be :it
    end
  end
end
