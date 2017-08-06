require 'spec_helper'

RSpec.describe ItunesApi::Music::Album, type: :model do
  let(:collection_id) { 696_312_806 }
  let(:store) { 'gb' }

  describe '.find_by_collection_id' do
    subject do
      VCR.use_cassette('album') do
        described_class.find_by_collection_id(collection_id, store)
      end
    end

    it { is_expected.to be_a described_class }

    it { expect(subject.name).to eql 'Ed Hunter' }
  end
end

RSpec.describe ItunesApi::Music::Album, type: :model do
  let(:apple_id) { 3_996_865 }
  let(:store) { 'gb' }

  describe '.for_artist' do
    subject do
      VCR.use_cassette('albums') { described_class.for_artist(apple_id, store) }
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
      'Iron Maiden',
      artwork_link,
      696_312_806,
      explicitness,
      'Metal',
      link,
      'Ed Hunter',
      release_on,
      store,
      20
    ]
  end

  let(:artwork_link) { 'http://.../source/100x100bb.jpg' }
  let(:explicitness) { '' }
  let(:link) { 'https://itunes.apple.com/gb/album/ed-hunter/id696312806?uo=4' }
  let(:release_on) { Date.parse '1999-05-17' }
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
          .and_return(Date.parse('1998-01-01'))
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
        artist: 'Iron Maiden',
        artwork: artwork_link,
        availability: :streaming,
        collection_id: 696_312_806,
        explicit: false,
        genre: 'Metal',
        link: link,
        name: 'Ed Hunter',
        release_on: release_on,
        store: 'gb',
        track_count: 20
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
