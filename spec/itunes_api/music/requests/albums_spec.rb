require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Albums, type: :model do
  let(:instance) { described_class.new(search_id, store) }

  let(:store) { 'gb' }

  describe '#find_by_apple_id' do
    subject { VCR.use_cassette('albums') { instance.find_by_apple_id } }

    let(:search_id) { 3_996_865 }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Results::Album }
  end

  describe '#find_by_collection_id' do
    subject { VCR.use_cassette('album') { instance.find_by_collection_id } }

    let(:search_id) { 696_312_806 }

    it { is_expected.to be_a ItunesApi::Music::Results::Album }

    it 'returns the expected result' do
      expect(subject.collection_id).to eql search_id
    end
  end
end
