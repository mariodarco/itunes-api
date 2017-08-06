require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Artist, type: :model do
  let(:instance) { described_class.new(apple_id, store) }

  let(:apple_id) { 414_425 }
  let(:store) { 'gb' }

  describe '#find_by_apple_id' do
    subject { VCR.use_cassette('lookup') { instance.find_by_apple_id } }

    it { is_expected.to be_a ItunesApi::Music::Results::Artist }

    it 'returns the expected result' do
      expect(subject.attributes).to eql [
        5_453,
        414_425,
        'Metal',
        'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4',
        'Slayer',
        'gb'
      ]
    end
  end
end
