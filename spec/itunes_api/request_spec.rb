require 'spec_helper'

describe ItunesApi::Request do
  let(:instance) { ItunesApi::Music::Album.new([artist_id]) }

  let(:artist_id)   { 1 }
  let(:json_data)   { parsed_data.to_json }
  let(:parsed_data) { { 'results' => { 'data' => 'value' } } }
  let(:opened_url)  { double(StringIO) }
  let(:url)         { 'https://example.apple.com' }

  before do
    allow(instance).to receive(:url).and_return url
    allow(instance).to receive(:open).with(url).and_return opened_url
    allow(opened_url).to receive(:read).and_return json_data
  end

  describe '#request' do
    subject { instance.request }

    it 'reads the given url' do
      expect(opened_url).to receive :read

      subject
    end
  end

  describe '#response' do
    subject { instance.response }

    it { is_expected.to eql parsed_data }
  end

  describe '#results' do
    subject { instance.results }

    it { is_expected.to eql parsed_data['results'] }
  end
end
