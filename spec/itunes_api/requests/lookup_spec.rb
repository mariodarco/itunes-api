require 'spec_helper'

describe ItunesApi::Requests::Lookup do
  let(:instance) { described_class.new(artist_id) }

  let(:artist_id) { 62819 }

  describe '#artist_with_albums' do
    subject do
      VCR.use_cassette('lookup') { instance.artist_with_albums }
    end

    it 'returns an hash of results about Jimi Hendrix' do
      expect(subject[:artistName]).to eql 'The Jimi Hendrix Experience'
    end

    it 'has an array of info about his albums' do
      expect(subject[:albums]).to be_a Array
    end
  end
end
