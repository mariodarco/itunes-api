require 'spec_helper'
require 'itunes_api/shared'

describe ItunesApi::Request do
  include_context 'api_requests'

  let(:instance) { ItunesApi::Music::Album.new([artist_id]) }

  let(:artist_id)   { 1 }
  let(:parsed_data) { { 'results' => { 'data' => 'value' } } }

  describe '#response' do
    subject { instance.response }

    it { is_expected.to eql parsed_data }
  end
end
