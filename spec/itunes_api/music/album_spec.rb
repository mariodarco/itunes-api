require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Music::Album do
  include_context 'api_requests'

  let(:instance) { described_class.new(album_name, filtering_options) }

  let(:album_name) { 'Gold' }
  let(:filtering_options) do
    {
      apple_id: 66,
      album_id: 2
    }
  end

  let(:parsed_data) do
    { 'results' => [track_1, track_2, track_3, track_4] }
  end

  let(:track_1) do
    {
      'artistId' => 99,
      'collectionId' => 1,
      'isStreamable' => true,
      'trackNumber' => 1
    }
  end

  let(:track_2) do
    {
      'artistId' => 66,
      'collectionId' => 2,
      'isStreamable' => true,
      'trackNumber' => 2
    }
  end

  let(:track_3) do
    {
      'artistId' => 66,
      'collectionId' => 3,
      'isStreamable' => false,
      'trackNumber' => 3
    }
  end

  let(:track_4) do
    {
      'artistId' => 66,
      'collectionId' => 2,
      'isStreamable' => true,
      'trackNumber' => 4
    }
  end

  describe '#tracks' do
    subject { instance.tracks }

    it { is_expected.to eql [track_2, track_4] }
  end

  describe '#apple_music?' do
    subject { instance.apple_music? }

    it { is_expected.to be true }

    context 'when album is not streamable' do
      let(:filtering_options) { { album_id: 3 } }

      it { is_expected.to be false }
    end
  end
end
