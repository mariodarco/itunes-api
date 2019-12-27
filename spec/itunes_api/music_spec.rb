# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music do
  let(:apple_id) { 414_425 }
  let(:collection_id) { 1_038_991_417 }
  let(:name) { 'Slayer' }
  let(:store) { :gb }
  let(:track_id) { 1_038_991_877 }

  describe '.find_by_name' do
    subject do
      VCR.use_cassette('search') do
        described_class.find_by_name(name, store)
      end
    end

    it { is_expected.to be_a(Array) }
    it { is_expected.to all be_a(ItunesApi::Music::Artist) }

    it 'has relevant results' do
      expect(subject.map(&:name)).to all be_include(name)
    end
  end

  describe '.find_by_apple_id' do
    subject do
      VCR.use_cassette('artist') do
        described_class.find_by_apple_id(apple_id, store)
      end
    end

    it { is_expected.to be_a(ItunesApi::Music::Artist) }

    it 'is the expected result' do
      expect(subject.apple_id).to eql apple_id
    end
  end

  describe '.find_albums_by_apple_id' do
    subject do
      VCR.use_cassette('albums') do
        described_class.find_albums_by_apple_id(apple_id, store)
      end
    end

    it { is_expected.to be_a(Array) }
    it { is_expected.to all be_a(ItunesApi::Music::Album) }
  end

  describe '.find_by_collection_id' do
    subject do
      VCR.use_cassette('album') do
        described_class.find_by_collection_id(collection_id, store)
      end
    end

    it { is_expected.to be_a(ItunesApi::Music::Album) }
  end

  describe '.find_songs_by_collection_id' do
    subject do
      VCR.use_cassette('songs') do
        described_class.find_songs_by_collection_id(collection_id, store)
      end
    end

    it { is_expected.to be_a(Array) }
    it { is_expected.to all be_a(ItunesApi::Music::Song) }
  end

  describe '.find_by_track_id' do
    let(:finder) { described_class.find_by_track_id(track_id, store) }

    subject do
      VCR.use_cassette('song') do
        finder
      end
    end

    it { is_expected.to be_a(ItunesApi::Music::Song) }

    context 'when a default store is not passed' do
      let(:finder) { described_class.find_by_track_id(track_id) }

      it { is_expected.to be_a(ItunesApi::Music::Song) }
    end
  end
end
