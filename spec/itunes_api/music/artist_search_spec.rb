require 'spec_helper'

describe ItunesApi::Music::ArtistSearch do
  let(:instance) { described_class.new(artist_name) }

  let(:artist_name) { 'The Jimi Hendrix Experience' }

  describe '#artists' do
    subject do
      VCR.use_cassette('search_and_lookup') { instance.artists }
    end

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Artist }

    it 'returns albums with each artist' do
      albums = subject.first.albums
      expect(albums).to be_a Array
      expect(albums).to all be_a ItunesApi::Music::Album
    end
  end
end
