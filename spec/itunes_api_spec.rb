require 'spec_helper'

describe ItunesApi do
  it 'has a base url' do
    expect(ItunesApi::BASE_URL).to eq 'https://itunes.apple.com'
  end

  it 'has a country code' do
    expect(ItunesApi::COUNTRY_CODE).to eq 'GB'
  end

  it 'has a limit' do
    expect(ItunesApi::LIMIT).to eq 200
  end

  describe '.artist_ids' do
    subject { described_class.artist_ids(name) }

    let(:name) { 'The Beatles' }

    it 'delegates the search to the Request::Search class' do
      expect(ItunesApi::Requests::Search).to receive(:artist_ids).with(name)

      subject
    end
  end

  describe '.artist_lookup' do
    subject { described_class.artist_lookup(id) }

    let(:id) { '5555' }

    it 'delegates the ArtistLookup class to retrieve artist from the query' do
      expect(ItunesApi::Music::ArtistLookup).to receive(:artist).with(id)

      subject
    end
  end

  describe '.artist_search' do
    subject { described_class.artist_search(name) }

    let(:name) { 'The Beatles' }

    it 'delegates the ArtistSearch class to retrieve artists from the query' do
      expect(ItunesApi::Music::ArtistSearch).to receive(:artists).with(name)

      subject
    end
  end
end
