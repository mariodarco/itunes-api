# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Results::Song, type: :model do
  let(:instance) { described_class.new(data, store) }

  let(:data) do
    {
      'artistName' => 'Slayer',
      'collectionName' => 'Reign In Blood',
      'previewUrl' => preview_link,
      'primaryGenreName' => 'Metal',
      'trackExplicitness' => 'notExplicit',
      'trackTimeMillis' => track_time,
      'trackViewUrl' => link,
      'trackName' => 'Raining Blood',
      'trackNumber' => 10,
      'isStreamable' => true,
      'trackId' => 1_038_991_417
    }
  end

  let(:expected_attributes) do
    [
      'Reign In Blood',
      'Slayer',
      '3:42',
      'notExplicit',
      'Metal',
      link,
      'Raining Blood',
      10,
      preview_link,
      store,
      true,
      1_038_991_417
    ]
  end

  let(:link) do
    'https://itunes.apple.com/gb/album/raining-blood/id1038991417?i=1038991877&uo=4'
  end

  let(:preview_link) do
    'http://a622.phobos.apple.com/us/r30/Music3/v4/73/d8/85/73d885fe-' \
      'd3ae-78c0-055a-345bb8c385ac/mzaf_3991867579915407602.plus.aac.p.m4a'
  end

  let(:store) { 'gb' }

  let(:track_time) { 222_377 }

  it { expect(instance.album).to eql 'Reign In Blood' }
  it { expect(instance.artist).to eql 'Slayer' }
  it { expect(instance.attributes).to eql expected_attributes }
  it { expect(instance.duration).to eql '3:42' }
  it { expect(instance.explicitness).to eql 'notExplicit' }
  it { expect(instance.genre).to eql 'Metal' }
  it { expect(instance.link).to eql link }
  it { expect(instance.name).to eql 'Raining Blood' }
  it { expect(instance.number).to eql 10 }
  it { expect(instance.preview).to eql preview_link }
  it { expect(instance.store).to eql 'gb' }
  it { expect(instance.streamable).to eql true }
  it { expect(instance.track_id).to eql 1_038_991_417 }

  context 'when data has no valid Track Time' do
    let(:track_time) { '' }

    it { expect(instance.duration).to eql '-:--' }
  end
end
