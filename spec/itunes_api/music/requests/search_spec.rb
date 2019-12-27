# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Search, type: :model do
  let(:instance) { described_class.new(artist_name, store) }

  let(:artist_name) { 'Slayer' }
  let(:store) { 'gb' }

  describe '#artists' do
    subject { VCR.use_cassette('search') { instance.artists } }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Results::Artist }

    it 'returns the expected result' do
      expect(subject.first.attributes).to eql [
        5_453,
        414_425,
        'Metal',
        'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4',
        artist_name,
        'gb'
      ]
    end
  end
end
