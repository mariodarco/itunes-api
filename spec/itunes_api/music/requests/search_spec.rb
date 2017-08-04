require 'spec_helper'

describe ItunesApi::Music::Requests::Search do
  let(:instance) { described_class.new(artist_name, store) }
  let(:artist_name) { 'Jimi Hendrix' }
  let(:store) { :gb }

  # describe '#artist_ids' do
  #   subject do
  #     VCR.use_cassette('search') { instance.artist_ids }
  #   end

  #   let(:processed_result) { [62852, 62819, 485340531] }

  #   it { is_expected.to eql processed_result }
  # end
end
