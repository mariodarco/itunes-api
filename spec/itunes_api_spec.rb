require 'spec_helper'

RSpec.describe ItunesApi do
  it 'has a base url' do
    expect(ItunesApi::BASE_URL).to eql 'https://itunes.apple.com'
  end

  it 'has a limit' do
    expect(ItunesApi::LIMIT).to eql 200
  end

  it 'has a version' do
    expect(ItunesApi::VERSION).to eql '2.0.0'
  end
end
