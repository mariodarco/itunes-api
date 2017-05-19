require 'spec_helper'
require 'itunes_api/requests/shared'

describe ItunesApi::Requests::Search do
  include_context 'api_requests'

  let(:instance) { described_class.new(artist_name) }

  let(:artist_name) { 'ABBA' }
  let(:body) { '{"results":[{"amgArtistId":999},{"amgArtistId":969}]}' }
  let(:request_url) do
    'https://itunes.apple.com/search?attribute=artistTerm&country=GB&entity=album&limit=200&media=music&sort=recent&term=ABBA'
  end

  describe '#artist_ids' do
    subject { instance.artist_ids }

    it { is_expected.to eql [969, 999] }
  end
end
