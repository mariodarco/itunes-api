require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Music::Album do
  include_context 'api_requests'

  let(:instance) { described_class.new([artist_id]) }

  let(:artist_id)     { 1 }
  let(:info)          { [info_album_second, info_album_first] }
  let(:info_playlist) { { 'collectionType' => 'Playlist' } }

  let(:info_album_first) do
    {
      'collectionType' => 'Album',
      'name' => 'First',
      'releaseDate' => '2015-11-13'
    }
  end

  let(:info_album_second) do
    {
      'collectionType' => 'Album',
      'name' => 'Second',
      'releaseDate' => '2016-11-14'
    }
  end

  let(:parsed_data) do
    {
      'results' => [info_album_first, info_album_second, info_playlist]
    }
  end

  it 'has a type' do
    expect(ItunesApi::Music::Album::TYPE).to eq 'Album'
  end

  describe '.info' do
    subject { described_class.info([artist_id]) }

    it 'calls info on a new instance of Album' do
      expect(described_class)
        .to receive(:new)
        .with([artist_id])
        .and_return instance
      expect(instance)
        .to receive(:info)
        .and_return info

      subject
    end
  end

  describe '#info' do
    subject { instance.info }

    it { is_expected.to eql info }
  end
end
