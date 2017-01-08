require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Music::Album do
  include_context 'api_requests'

  let(:instance) { described_class.new(info) }

  let(:results) { [track_1, track_2, track_3, track_4] }
  let(:parsed_data) { { 'results' => results } }

  let(:info) do
    {
      'collectionName' => 'Gold',
      'collectionId' => 2,
      'artworkUrl100' => 'http://somewhere.com',
      'trackCount' => '20',
      'releaseDate' => '2016-12-02'
    }
  end

  let(:track_1) { { 'collectionId' => 1, 'isStreamable' => true } }
  let(:track_2) { { 'collectionId' => 2, 'isStreamable' => true } }
  let(:track_3) { { 'collectionId' => 3, 'isStreamable' => false } }
  let(:track_4) { { 'collectionId' => 2, 'isStreamable' => false } }

  describe '#apple_music?' do
    subject { instance.apple_music? }

    it { is_expected.to be true }

    context 'when no track on the album is streamable' do
      let(:results) { [track_3] }

      it { is_expected.to be false }
    end
  end

  describe '#streamable_tracks' do
    subject { instance.streamable_tracks }

    it { is_expected.to eql [track_2] }
  end

  describe '#tracks' do
    subject { instance.tracks }

    it { is_expected.to eql [track_2, track_4] }
  end
end
