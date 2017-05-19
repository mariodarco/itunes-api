require 'spec_helper'
require 'itunes_api/requests/shared'

describe ItunesApi::Requests::Lookup do
  include_context 'api_requests'

  let(:instance) { described_class.new(artist_name) }

  let(:artist_name) { 'Iron Maiden' }
  let(:body) do
    {
      'results' => [
        { 'wrapperType' => 'artist', 'artistName' => 'Iron Maiden' },
        { 'wrapperType' => 'collection', 'albumName' => 'Killers' },
        { 'wrapperType' => 'collection', 'albumName' => 'Iron Maiden' }
      ]
    }.to_json
  end
  let(:request_url) { 'https://itunes.apple.com/lookup?amgArtistId=Iron%20Maiden&country=GB&entity=album&limit=200&sort=recent' }

  describe '#artist_with_albums' do
    subject { instance.artist_with_albums }

    let(:processed_result) do
      {
        artistName: 'Iron Maiden',
        albums: [
          { albumName: 'Killers' },
          { albumName: 'Iron Maiden' }
        ]
      }
    end

    it { is_expected.to eql processed_result }
  end
end
