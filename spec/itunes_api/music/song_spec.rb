require 'spec_helper'

RSpec.describe ItunesApi::Music::Song, type: :model do
  let(:collection_id) { 1_038_991_417 }
  let(:store) { 'gb' }

  describe '.find_by_collection_id' do
    subject do
      VCR.use_cassette('songs') do
        described_class.find_by_collection_id(collection_id, store)
      end
    end

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a described_class }
  end
end

RSpec.describe ItunesApi::Music::Song, type: :model do
  let(:track_id) { 1_038_991_877 }
  let(:store) { 'gb' }

  describe '.find_by_track_id' do
    subject do
      VCR.use_cassette('song') do
        described_class.find_by_track_id(track_id, store)
      end
    end

    it { is_expected.to be_a described_class }

    it { expect(subject.name).to eql 'Raining Blood' }
  end
end

RSpec.describe ItunesApi::Music::Song, type: :model do
  let(:instance) do
    described_class.new(*attributes)
  end

  let(:attributes) do
    [
      'Reign In Blood',
      'Slayer',
      '3:42',
      'notExplicit',
      'Metal',
      link,
      'Raining Blood',
      10,
      preview_link,
      store,
      true,
      1_038_991_877
    ]
  end

  let(:link) do
    'https://itunes.apple.com/gb/album/raining-blood/id1038991417?i=1038991877&uo=4'
  end

  let(:preview_link) do
    'http://a622.phobos.apple.com/us/r30/Music3/v4/73/d8/85/73d885fe-d3ae-78c0-055a-345bb8c385ac/mzaf_3991867579915407602.plus.aac.p.m4a'
  end

  let(:store) { 'gb' }

  describe '#to_hash' do
    subject { instance.to_hash }

    let(:expected_hash) do
      {
        album: 'Reign In Blood',
        artist: 'Slayer',
        duration: '3:42',
        explicit: false,
        genre: 'Metal',
        link: link,
        name: 'Raining Blood',
        number: 10,
        preview: preview_link,
        store: 'gb',
        streamable: true,
        track_id: 1_038_991_877
      }
    end

    it { is_expected.to eql expected_hash }
  end
end
