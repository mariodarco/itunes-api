require 'spec_helper'
require 'itunes_api/requests/shared'

describe ItunesApi::Requests::Search do
  include_context 'api_requests'

  let(:instance) { described_class.new(artist_name) }

  let(:artist_name) { 'ABBA' }
  let(:parsed_data) do
    {
      'results' => [
        { 'amgArtistId' => 999 },
        { 'amgArtistId' => 969 }
      ]
    }
  end

  describe '#artist_ids' do
    subject { instance.artist_ids }

    it { is_expected.to eql [969, 999] }
  end
end
