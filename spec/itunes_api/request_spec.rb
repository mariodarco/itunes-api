require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Request do
  include_context 'api_requests'

  let(:instance) { ItunesApi::Music::Artist.new(artist_name) }

  let(:artist_name) { 'ABBA' }
  let(:parsed_data) { { 'results' => { 'data' => 'value' } } }

  describe '#response' do
    subject { instance.response }

    it { is_expected.to eql parsed_data }
  end
end
