require 'spec_helper'

describe ItunesApi::Music::Album do
  let(:instance) { described_class.new(first_album_data, store) }

  let(:first_album_data) do
    {
      collectionName: 'The Dark Side of The Moon',
      artworkUrl100: 'http://example.com/tdsotm.jpg',
      collectionId: '999666',
      releaseDate: first_date_string
    }
  end
  let(:first_date_string) { '1973-03-01' }
  let(:first_date) { Date.parse(first_date_string) }
  let(:store) { :gb }

  describe '.build' do
    subject { described_class.build(albums_data, store) }

    let(:albums_data) { [first_album_data, second_album_data] }
    let(:second_album_data) do
      {
        collectionName: 'The Wall',
        artworkUrl100: 'http://example.com/tw.jpg',
        collectionId: '999667',
        releaseDate: second_date_string
      }
    end
    let(:second_date_string) { '1979-11-30' }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a described_class }
  end

  describe '#artwork' do
    subject { instance.artwork }

    it { is_expected.to eql 'http://example.com/tdsotm.jpg' }
  end

  describe '#collection_id' do
    subject { instance.collection_id }

    it { is_expected.to eql '999666' }
  end

  describe '#name' do
    subject { instance.name }

    it { is_expected.to eql 'The Dark Side of The Moon' }
  end

  describe '#released' do
    subject { instance.released }

    it { is_expected.to eql first_date }
  end

  describe '#to_hash' do
    subject do
      VCR.use_cassette('album_lookup') { instance.to_hash }
    end

    let(:album_data) do
      {
        artwork: 'http://example.com/tdsotm.jpg',
        collection_id: '999666',
        name: 'The Dark Side of The Moon',
        released: first_date,
        availability: :sale,
        store: :gb
      }
    end

    it { is_expected.to eql album_data }
  end
end
