require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Music::Artist do
  include_context 'api_requests'

  let(:instance) { described_class.new(artist_name, apple_id) }

  let(:apple_id)    { 99 }
  let(:artist_name) { 'ABBA' }
  
  let(:parsed_data) do
    { 'results' => [result_1, result_2, result_3, result_4] }
  end

  let(:result_1) do
    {
      'artistId' => 66,
      'collectionType' => 'Album',
      'collectionId' => 1,
      'collectionName' => 'Very Bad Album',
      'releaseDate' => '2015-11-13'
    }
  end

  let(:result_2) do
    {
      'artistId' => 99,
      'collectionType' => 'Album',
      'collectionId' => 2,
      'collectionName' => 'First Album',
      'releaseDate' => '2014-10-12'
    }
  end

  let(:result_3) do
    {
      'artistId' => 99,
      'collectionType' => 'Other',
      'collectionId' => 3,
      'collectionName' => 'What is this?',
      'releaseDate' => '2000-01-01'
    }
  end

  let(:result_4) do
    {
      'artistId' => 99,
      'collectionType' => 'Album',
      'collectionId' => 4,
      'collectionName' => 'Second Album',
      'releaseDate' => '2016-10-17'
    }
  end

  describe '#albums' do
    subject { instance.albums }

    it 'creates instance of the artist albums, sorted by most recent' do
      expect(subject.map(&:name)).to eql ['Second Album', 'First Album']
    end

    context 'when no apple id is given' do
      let(:apple_id) { nil }

      it 'creates instance of all albums, sorted by most recent' do
        expect(subject.map(&:name))
          .to eql ['Second Album', 'Very Bad Album', 'First Album']
      end
    end
  end

  describe '#apple_ids' do
    subject { instance.apple_ids }

    it { is_expected.to eql [99] }

    context 'when no apple id is given' do
      let(:apple_id) { nil }

      it { is_expected.to eql [66, 99] }
    end
  end
end
