require 'spec_helper'

describe ItunesApi do
  it 'has a base url' do
    expect(ItunesApi::BASE_URL).to eq 'https://itunes.apple.com'
  end

  it 'has a limit' do
    expect(ItunesApi::LIMIT).to eq 200
  end

  describe '.artist_ids' do
    subject { described_class.artist_ids(name, store) }

    let(:name) { 'The Beatles' }
    let(:store) { :it }

    it 'delegates the search to the Request::Search class' do
      expect(ItunesApi::Requests::Search).to receive(:artist_ids).with(name, store)

      subject
    end
  end

  # describe '.artist_lookup' do
  #   subject { described_class.artist_lookup(id, store) }

  #   let(:id) { '5555' }
  #   let(:store) { :it }

  #   it 'delegates the ArtistLookup class to retrieve artist from the query' do
  #     expect(ItunesApi::Music::ArtistLookup).to receive(:artist).with(id, store)

  #     subject
  #   end
  # end

  # describe '.artist_search' do
  #   subject { described_class.artist_search(name, store) }

  #   let(:name) { 'The Beatles' }
  #   let(:store) { :it }

  #   it 'delegates the ArtistSearch class to retrieve artists from the query' do
  #     expect(ItunesApi::Music::ArtistSearch).to receive(:artists).with(name, store)

  #     subject
  #   end
  # end
end
