require 'spec_helper'

describe ItunesApi do
  it 'has a country code' do
    expect(ItunesApi::COUNTRY_CODE).to eq 'GB'
  end

  it 'has a base url' do
    expect(ItunesApi::BASE_URL).to eq 'https://itunes.apple.com'
  end
end
