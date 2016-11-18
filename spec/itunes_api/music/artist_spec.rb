require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Music::Artist do
  include_context 'api_requests'

  let(:instance) { described_class.new([artist_name]) }

  let(:artist_name)   { 'Abba' }
  let(:retrieved_ids) { [66, 99] }

  let(:parsed_data) do
    {
      'results' => [
        { 'artistId' => 66 },
        { 'artistId' => 99 }
      ]
    }
  end

  describe '.apple_ids' do
    subject { described_class.apple_ids(artist_name) }

    it 'calls apple_ids on a new instance of Artist' do
      expect(described_class)
        .to receive(:new)
        .with(artist_name)
        .and_return instance
      expect(instance)
        .to receive(:apple_ids)
        .and_return retrieved_ids

      subject
    end
  end

  describe '#apple_ids' do
    subject { instance.apple_ids }

    it { is_expected.to eql retrieved_ids }
  end
end
