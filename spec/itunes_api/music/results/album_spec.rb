require 'spec_helper'

RSpec.describe ItunesApi::Music::Results::Album, type: :model do
  let(:instance) { described_class.new(data, store) }

  let(:data) do
    {
      'artistName' => 'Iron Maiden',
      'artworkUrl100' => artwork_link,
      'collectionExplicitness' => 'explicit',
      'collectionId' => 696_312_806,
      'collectionName' => 'Ed Hunter',
      'collectionViewUrl' => link,
      'primaryGenreName' => 'Metal',
      'releaseDate' => '1999-05-17',
      'trackCount' => 20
    }
  end

  let(:expected_attributes) do
    [
      'Iron Maiden',
      artwork_link,
      696_312_806,
      'explicit',
      'Metal',
      link,
      'Ed Hunter',
      release_on,
      store,
      20
    ]
  end

  let(:artwork_link) { 'http://.../source/100x100bb.jpg' }
  let(:link) { 'https://itunes.apple.com/gb/album/ed-hunter/id696312806?uo=4' }
  let(:release_on) { Date.parse '1999-05-17' }
  let(:store) { 'gb' }

  it { expect(instance.artist).to eql 'Iron Maiden' }
  it { expect(instance.artwork).to eql artwork_link }
  it { expect(instance.attributes).to eql expected_attributes }
  it { expect(instance.collection_id).to eql 696_312_806 }
  it { expect(instance.explicitness).to eql 'explicit' }
  it { expect(instance.genre).to eql 'Metal' }
  it { expect(instance.link).to eql link }
  it { expect(instance.name).to eql 'Ed Hunter' }
  it { expect(instance.release_on).to eql release_on }
  it { expect(instance.store).to eql 'gb' }
  it { expect(instance.track_count).to eql 20 }
end
