# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Album, type: :model do
  let(:collection_id) { 1_038_991_417 }
  let(:store) { 'gb' }

  describe '.find_by_collection_id' do
    subject do
      VCR.use_cassette('album') do
        described_class.find_by_collection_id(collection_id, store)
      end
    end

    it { is_expected.to be_a described_class }

    it { expect(subject.name).to eql 'Reign In Blood' }
  end
end

RSpec.describe ItunesApi::Music::Album, type: :model do
  let(:apple_id) { 414_425 }
  let(:store) { 'gb' }

  describe '.find_by_apple_id' do
    subject do
      VCR.use_cassette('albums') do
        described_class.find_by_apple_id(apple_id, store)
      end
    end

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a described_class }
  end
end

RSpec.describe ItunesApi::Music::Album, type: :model do
  let(:instance) do
    described_class.new(*attributes)
  end

  let(:attributes) do
    [
      'Slayer',
      artwork_link,
      1_038_991_417,
      explicitness,
      'Metal',
      link,
      'Reign In Blood',
      release_on,
      store,
      10
    ]
  end

  let(:link) do
    'https://itunes.apple.com/gb/album/reign-in-blood/id1038991417?uo=4'
  end

  let(:artwork_link) do
    'http://is4.mzstatic.com/image/thumb/Music3/v4/ee/f9/ed/' \
      'eef9ed9f-5539-6356-319c-d91676811eab/source/100x100bb.jpg'
  end

  let(:explicitness) { '' }
  let(:release_on) { Date.parse '1986-10-07' }
  let(:store) { 'gb' }

  describe '#availability' do
    subject do
      VCR.use_cassette('songs') { instance.availability }
    end

    it { is_expected.to be :streaming }

    context 'album is not released yet' do
      before do
        allow(Date)
          .to receive(:today)
          .and_return(Date.parse('1986-01-01'))
      end

      it { is_expected.to be :pre_release_streaming }
    end

    context 'album is not on apple music' do
      let(:song) { double(ItunesApi::Music::Song, streamable?: false) }

      before do
        allow(instance)
          .to receive(:tracklist)
          .and_return([song])
      end

      it { is_expected.to be :sale }
    end
  end

  describe '#explicit?' do
    subject { instance.explicit? }

    it { is_expected.to be false }

    context 'when the album has explicit content' do
      let(:explicitness) { 'explicit' }

      it { is_expected.to be true }
    end
  end

  describe '#to_hash' do
    subject do
      VCR.use_cassette('songs') { instance.to_hash }
    end

    let(:expected_hash) do
      {
        artist: 'Slayer',
        artwork: artwork_link,
        availability: :streaming,
        collection_id: 1_038_991_417,
        explicit: false,
        genre: 'Metal',
        link: link,
        name: 'Reign In Blood',
        release_on: release_on,
        store: 'gb',
        track_count: 10
      }
    end

    it { is_expected.to eql expected_hash }
  end

  describe '#tracklist' do
    subject do
      VCR.use_cassette('songs') { instance.tracklist }
    end

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Song }
  end
end
