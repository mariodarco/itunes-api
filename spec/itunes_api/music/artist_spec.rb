require 'spec_helper'

describe ItunesApi::Music::Artist do
  let(:instance) { described_class.new(artist_data) }

  let(:album_data) do
    {
      'collectionName' => 'The Wall',
      'artworkUrl100' => 'http://example.com/tw.jpg',
      'releaseDate' => '1979-11-30'
    }
  end

  let(:artist_data) do
    {
      'artistName' => 'Pink Floyd',
      'amgArtistId' => 5959,
      :albums => [album_data]
    }
  end

  describe '#albums' do
    subject { instance.albums }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Album }
  end

  describe '#artist_id' do
    subject { instance.artist_id }

    it { is_expected.to eql 5959 }
  end

  describe '#name' do
    subject { instance.name }

    it { is_expected.to eql 'Pink Floyd' }
  end
end
