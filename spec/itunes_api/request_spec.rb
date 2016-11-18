require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Request do
  include_context 'api_requests'

  let(:instance) { ItunesApi::Music::Album.new([artist_id]) }

  let(:artist_id)   { 1 }
  let(:parsed_data) { { 'results' => { 'data' => 'value' } } }

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
