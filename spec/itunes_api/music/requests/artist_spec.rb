require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Artist, type: :model do
  let(:instance) { described_class.new(apple_id, store) }

  let(:apple_id) { 3_996_865 }
  let(:store) { 'gb' }

  describe '#find_by_apple_id?' do
    subject { VCR.use_cassette('lookup') { instance.find_by_apple_id } }

    it { is_expected.to be_a ItunesApi::Music::Results::Artist }

    it 'returns the expected result' do
      expect(subject.attributes).to eql [
        4_906,
        3_996_865,
        'Rock',
        'https://itunes.apple.com/gb/artist/metallica/id3996865?uo=4',
        'Metallica',
        'gb'
      ]
    end
  end
end
