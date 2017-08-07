require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Songs, type: :model do
  let(:instance) { described_class.new(search_id, store) }
  let(:search_id) { 1_038_991_877 }
  let(:store) { 'gb' }

  describe '#find_by_id' do
    subject { VCR.use_cassette('song') { instance.find_by_id } }

    let(:link) do
      'https://itunes.apple.com/gb/album/raining-blood/id1038991417?i=1038991877&uo=4'
    end

    let(:preview_link) do
      'http://a622.phobos.apple.com/us/r30/Music3/v4/73/d8/85/73d885fe-' \
        'd3ae-78c0-055a-345bb8c385ac/mzaf_3991867579915407602.plus.aac.p.m4a'
    end

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Results::Song }

    it 'returns the expected result' do
      expect(subject.first.attributes).to eql(
        [
          'Reign In Blood', 'Slayer', '3:42', 'notExplicit',
          'Metal', link, 'Raining Blood', 10,
          preview_link, 'gb', true, search_id
        ]
      )
    end
  end
end
