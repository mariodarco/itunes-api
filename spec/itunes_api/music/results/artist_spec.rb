# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Results::Artist, type: :model do
  let(:instance) { described_class.new(data, store, search_term) }

  let(:data) do
    {
      'amgArtistId' => 5_453,
      'artistId' => 414_425,
      'artistLinkUrl' => link,
      'artistName' => 'Slayer',
      'primaryGenreName' => 'Metal'
    }
  end

  let(:expected_attributes) do
    [5_453, 414_425, 'Metal', link, 'Slayer', 'gb']
  end

  let(:link) { 'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4' }
  let(:search_term) { 'Iron Maiden' }
  let(:store) { 'gb' }

  it { expect(instance.amg_id).to eql 5_453 }
  it { expect(instance.apple_id).to eql 414_425 }
  it { expect(instance.attributes).to eql expected_attributes }
  it { expect(instance.genre).to eql 'Metal' }
  it { expect(instance.link).to eql link }
  it { expect(instance.name).to eql 'Slayer' }
  it { expect(instance.store).to eql 'gb' }
end

RSpec.describe ItunesApi::Music::Results::Artist, type: :model do
  let(:instance) { described_class.new(data, store, search_term) }

  let(:artist_name) { 'Manowar' }
  let(:data) { { 'artistName' => artist_name } }
  let(:search_term) { nil }
  let(:store) { 'gb' }

  describe '#relevant?' do
    subject { instance.relevant? }

    context 'when no search term is given' do
      it { is_expected.to be true }
    end

    context 'when a search term is given' do
      let(:search_term) { 'ManOwaR' }

      context 'and the result name contains the search term' do
        let(:artist_name) { 'The Manowar Tribute' }

        it { is_expected.to be true }
      end

      context 'and the result name does not contain the search term' do
        let(:artist_name) { 'Men of War' }

        it { is_expected.to be false }
      end
    end
  end
end
