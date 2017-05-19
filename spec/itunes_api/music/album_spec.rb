require 'spec_helper'

describe ItunesApi::Music::Album do
  let(:instance) { described_class.new(first_album_data) }

  let(:first_album_data) do
    {
      collectionName: 'The Dark Side of The Moon',
      artworkUrl100: 'http://example.com/tdsotm.jpg',
      releaseDate: first_date
    }
  end
  let(:first_date) { '1973-03-01' }

  describe '.build' do
    subject { described_class.build(albums_data) }

    let(:albums_data) { [first_album_data, second_album_data] }
    let(:second_album_data) do
      {
        collectionName: 'The Wall',
        artworkUrl100: 'http://example.com/tw.jpg',
        releaseDate: second_date
      }
    end
    let(:second_date) { '1979-11-30' }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a described_class }
  end

  describe '#artwork' do
    subject { instance.artwork }

    it { is_expected.to eql 'http://example.com/tdsotm.jpg' }
  end

  describe '#name' do
    subject { instance.name }

    it { is_expected.to eql 'The Dark Side of The Moon' }
  end

  describe '#released' do
    subject { instance.released }

    it { is_expected.to eql Date.parse(first_date) }
  end
end
