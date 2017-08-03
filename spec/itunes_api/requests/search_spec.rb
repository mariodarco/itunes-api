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
        62852, 62819, 387969348, 36270, 80204262,
        4035426, 825559, 331122, 325232, 1249595,
        74494247,485340531, 309237425, 92345680
      ]
    end

    it { is_expected.to eql processed_result }
  end
end
