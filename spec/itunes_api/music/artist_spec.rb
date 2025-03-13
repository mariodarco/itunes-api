# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Artist, type: :model do
  describe '.find_by_name' do
    subject { described_class.find_by_name(name, store) }

    let(:attributes_slayer) { ['', '', '', '', 'Slayer', ''] }
    let(:attributes_slayer2) { ['', '', '', '', 'Princess Slayer', ''] }
    let(:slayer) { double(result_class, attributes: attributes_slayer) }
    let(:slayer2) { double(result_class, attributes: attributes_slayer2) }
    let(:result_class) { ItunesApi::Music::Results::Artist }
    let(:result_names) { ['Slayer', 'Princess Slayer'] }
    let(:results) { [slayer, slayer2] }
    let(:name) { 'Slayer' }
    let(:store) { 'gb' }

    before do
      allow(ItunesApi::Music::Requests::Search)
        .to receive(:artists)
        .with(name, store)
        .and_return(results)
    end

    it { is_expected.to be_an Array }
    it { is_expected.to all be_a described_class }

    it { expect(subject.map(&:name)).to eql result_names }
  end
end

RSpec.describe ItunesApi::Music::Artist, type: :model do
  describe '.find_by_apple_id' do
    subject { described_class.find_by_apple_id(apple_id, store) }

    let(:apple_id) { 414_425 }
    let(:attributes) { ['', '', '', '', 'Slayer', ''] }
    let(:store) { 'gb' }

    let(:results) do
      [double(ItunesApi::Music::Results::Artist, attributes: attributes)]
    end

    before do
      allow(ItunesApi::Music::Requests::Artist)
        .to receive(:find_by_id)
        .with(apple_id, store)
        .and_return(results)
    end

    it { is_expected.to be_a described_class }

    it { expect(subject.name).to eql 'Slayer' }
  end
end

RSpec.describe ItunesApi::Music::Artist, type: :model do
  let(:instance) do
    described_class.new(*attributes)
  end

  let(:attributes) { [5_453, apple_id, 'Metal', link, 'Slayer', store] }

  let(:apple_id) { 414_425 }
  let(:link) { 'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4' }
  let(:store) { 'gb' }

  describe '#albums' do
    it 'delegates the Album class to retrieve albums' do
      expect(ItunesApi::Music::Album)
        .to receive(:find_by_apple_id)
        .with(apple_id, store)

      instance.albums
    end
  end
end

RSpec.describe ItunesApi::Music::Artist, type: :model do
  let(:instance) do
    described_class.new(amg_id, apple_id, genre, link, name, store)
  end

  let(:attributes) { [5_453, apple_id, 'Metal', link, 'Slayer', store] }

  let(:amg_id) { 5_453 }
  let(:apple_id) { 414_425 }
  let(:genre) { 'Metal' }
  let(:link) { 'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4' }
  let(:name) { 'Slayer' }
  let(:store) { 'gb' }

  describe '#to_hash' do
    subject { instance.to_hash }

    let(:expected_hash) do
      {
        amg_id: 5_453,
        apple_id: 414_425,
        genre: 'Metal',
        link: 'https://itunes.apple.com/gb/artist/slayer/id414425?uo=4',
        name: 'Slayer',
        store: 'gb'
      }
    end

    it { is_expected.to eql expected_hash }
  end
end
