require 'spec_helper'

describe ItunesApi::Requests::Search do
  let(:instance) { described_class.new(artist_name) }
  let(:artist_name) { 'Jimi Hendrix' }

  describe '#artist_ids' do
    subject do
      VCR.use_cassette('search') { instance.artist_ids }
    end

    let(:processed_result) do
      [5298, 5723, 74578, 85934, 295992]
    end

    it { is_expected.to eql processed_result }
  end
end
