# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ItunesApi::Music::Requests::Albums, type: :model do
  let(:instance) { described_class.new(search_id, store) }

  let(:store) { 'gb' }

  describe '#find_by_id' do
    subject { VCR.use_cassette('albums') { instance.find_by_id } }

    let(:search_id) { 414_425 }

    it { is_expected.to be_a Array }
    it { is_expected.to all be_a ItunesApi::Music::Results::Album }
  end
end
