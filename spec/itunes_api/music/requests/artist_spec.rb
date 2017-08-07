require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Artist, type: :model do
  let(:instance) { described_class.new(search_id, store) }

  let(:search_id) { 414_425 }
  let(:store) { 'gb' }

  describe '#find_by_id' do
    subject { VCR.use_cassette('artist') { instance.find_by_id } }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Results::Artist }

    it 'returns the expected result' do
      expect(subject.first.attributes).to eql [
        5_453,
        search_id,
        'Metal',
        'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4',
        'Slayer',
        'gb'
      ]
    end
  end
end
