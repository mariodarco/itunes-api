require 'spec_helper'

describe ItunesApi::Music::ArtistLookup do
  let(:instance) { described_class.new(artist_id) }

  let(:artist_id) { 62819 }

  describe '#artist' do
    subject do
      VCR.use_cassette('lookup') { instance.artist }
    end

    it { is_expected.to be_a ItunesApi::Music::Artist }

    it 'returns albums of the artist' do
      albums = subject.albums
      expect(albums).to be_a Array
      expect(albums).to all be_a ItunesApi::Music::Album
    end
  end
end
