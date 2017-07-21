require 'spec_helper'

describe ItunesApi::Requests::Search do
  let(:instance) { described_class.new(artist_name, store) }
  let(:artist_name) { 'Jimi Hendrix' }
  let(:store) { :gb }

  describe '#artist_ids' do
    subject do
      VCR.use_cassette('search') { instance.artist_ids }
    end

    let(:processed_result) do
      [
        36270, 62819, 62852,
        325232, 331122, 825559,
        1249595, 4035426, 74494247, 80204262, 92345680,
        309237425, 387969348, 485340531
      ]
    end

    it { is_expected.to eql processed_result }
  end
end
