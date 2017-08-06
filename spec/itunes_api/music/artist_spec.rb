require 'spec_helper'

RSpec.describe ItunesApi::Music::Artist, type: :model do
  describe '.all_apple_ids' do
    subject { described_class.all_apple_ids(name, store) }

    let(:artist_1) { double(ItunesApi::Music::Artist, apple_id: 666) }
    let(:artist_2) { double(ItunesApi::Music::Artist, apple_id: 999) }
    let(:artists) { [artist_1, artist_2] }
    let(:name) { 'Satan' }
    let(:store) { 'us' }

    before do
      allow(described_class)
        .to receive(:find_all_by_name)
        .with(name, store)
        .and_return(artists)
    end

    it { is_expected.to eql [666, 999] }
  end
end

RSpec.describe ItunesApi::Music::Artist, type: :model do
  describe '.find_all_by_name' do
    subject { described_class.find_all_by_name(name, store) }

    let(:attributes_1) { ['', '', '', '', 'Iron Maiden', ''] }
    let(:attributes_2) { ['', '', '', '', 'Iron Maiden Tribute', ''] }
    let(:result_1) { double(result_class, attributes: attributes_1) }
    let(:result_2) { double(result_class, attributes: attributes_2) }
    let(:result_class) { ItunesApi::Music::Results::Artist }
    let(:result_names) { ['Iron Maiden', 'Iron Maiden Tribute'] }
    let(:results) { [result_1, result_2] }
    let(:name) { 'Maiden' }
    let(:store) { 'us' }

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

    let(:apple_id) { 666 }
    let(:attributes) { ['', '', '', '', 'Iron Maiden', ''] }
    let(:store) { 'us' }

    let(:result) do
      double(ItunesApi::Music::Results::Artist, attributes: attributes)
    end

    before do
      allow(ItunesApi::Music::Requests::Artist)
        .to receive(:find_by_apple_id)
        .with(apple_id, store)
        .and_return(result)
    end

    it { is_expected.to be_a described_class }

    it { expect(subject.name).to eql 'Iron Maiden' }
  end
end

RSpec.describe ItunesApi::Music::Artist, type: :model do
  let(:instance) do
    described_class.new(*attributes)
  end

  let(:attributes) { [4_906, apple_id, 'Rock', 'http', 'Metallica', store] }

  let(:apple_id) { 3_996_865 }
  let(:store) { 'gb' }

  describe '#albums' do
    it 'delegates the Album class to retrieve albums' do
      expect(ItunesApi::Music::Album)
        .to receive(:for_artist)
        .with(apple_id, store)

      instance.albums
    end
  end
end

RSpec.describe ItunesApi::Music::Artist, type: :model do
  let(:instance) do
    described_class.new(amg_id, apple_id, genre, link, name, store)
  end

  let(:amg_id) { 4_906 }
  let(:apple_id) { 3_996_865 }
  let(:genre) { 'Rock' }
  let(:link) { 'https://itunes.apple.com/gb/artist/metallica/id3996865?uo=4' }
  let(:name) { 'Metallica' }
  let(:store) { 'gb' }

  describe '#to_hash' do
    subject { instance.to_hash }

    let(:expected_hash) do
      {
        amg_id: 4_906,
        apple_id: 3_996_865,
        genre: 'Rock',
        link: 'https://itunes.apple.com/gb/artist/metallica/id3996865?uo=4',
        name: 'Metallica',
        store: 'gb'
      }
    end

    it { is_expected.to eql expected_hash }
  end
end

