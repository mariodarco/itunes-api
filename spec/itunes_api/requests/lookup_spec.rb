require 'spec_helper'
require 'itunes_api/requests/shared'

describe ItunesApi::Requests::Lookup do
  include_context 'api_requests'

  let(:instance) { described_class.new(artist_name) }

  let(:artist_name) { 'Iron Maiden' }
  let(:parsed_data) do
    {
      'results' => [
        { 'wrapperType' => 'artist', 'artistName' => 'Iron Maiden' },
        { 'wrapperType' => 'collection', 'albumName' => 'Killers' },
        { 'wrapperType' => 'collection', 'albumName' => 'Iron Maiden' }
      ]
    }
  end

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
