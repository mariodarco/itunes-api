# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Results::Album, type: :model do
  let(:instance) { described_class.new(data, store) }

  let(:data) do
    {
      'artistName' => 'Slayer',
      'artworkUrl100' => artwork_link,
      'collectionExplicitness' => 'explicit',
      'collectionId' => 1_038_991_417,
      'collectionName' => 'Reign In Blood',
      'collectionViewUrl' => link,
      'primaryGenreName' => 'Metal',
      'releaseDate' => '1986-10-07',
      'trackCount' => 10
    }
  end

  let(:expected_attributes) do
    [
      'Slayer',
      artwork_link,
      1_038_991_417,
      'explicit',
      'Metal',
      link,
      'Reign In Blood',
      release_on,
      store,
      10
    ]
  end

  let(:link) do
    'https://itunes.apple.com/gb/album/reign-in-blood/id1038991417?uo=4'
  end

  let(:artwork_link) { 'http://.../source/100x100bb.jpg' }
  let(:release_on) { Date.parse '1986-10-07' }
  let(:store) { 'gb' }

  it { expect(instance.artist).to eql 'Slayer' }
  it { expect(instance.artwork).to eql artwork_link }
  it { expect(instance.attributes).to eql expected_attributes }
  it { expect(instance.collection_id).to eql 1_038_991_417 }
  it { expect(instance.explicitness).to eql 'explicit' }
  it { expect(instance.genre).to eql 'Metal' }
  it { expect(instance.link).to eql link }
  it { expect(instance.name).to eql 'Reign In Blood' }
  it { expect(instance.release_on).to eql release_on }
  it { expect(instance.store).to eql 'gb' }
  it { expect(instance.track_count).to eql 10 }
end
