require 'spec_helper'

describe ItunesApi::Music::Artist do
  let(:instance) { described_class.new([artist_name]) }

  let(:artist_name)   { 'Abba' }
  let(:json_data)     { parsed_data.to_json }
  let(:opened_url)    { double(StringIO) }
  let(:retrieved_ids) { [66, 99] }
  let(:url)           { 'https://example.apple.com' }

  let(:parsed_data) do
    {
      'results' => [
        {'artistId' => 66 },
        {'artistId' => 99 }
      ]
    }
  end

  before do
    allow(instance).to receive(:url).and_return url
    allow(instance).to receive(:open).with(url).and_return opened_url
    allow(opened_url).to receive(:read).and_return json_data
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
