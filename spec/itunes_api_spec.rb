require 'spec_helper'

describe ItunesApi do
  it 'has a base url' do
    expect(ItunesApi::BASE_URL).to eql 'https://itunes.apple.com'
  end

  it 'has a limit' do
    expect(ItunesApi::LIMIT).to eql 200
  end

  it 'has a version' do
    expect(ItunesApi::VERSION).to eql '2.0.0'
  end
end

# describe ItunesApi do
#   let(:name) { 'The Beatles' }
#   let(:search_class) { ItunesApi::Requests::Search }
#   let(:store) { :it }

#   describe '.artist_ids' do
#     subject { described_class.artist_ids(name, store) }

#     it 'delegates the search to the Request::Search class' do
#       expect(search_class).to receive(:artist_ids).with(name, store)

#       subject
#     end

#     context 'when no store is specified' do
#       subject { described_class.artist_ids(name) }

#       it 'performs the search on the default store' do
#         expect(search_class).to receive(:artist_ids).with(name, :gb)

#         subject
#       end
#     end
#   end

#   describe '.artist_data' do
#     subject { described_class.artist_data(name, store) }

#     it 'delegates the search to the Request::Search class' do
#       expect(search_class).to receive(:artist_data).with(name, store)

#       subject
#     end
#   end
# end

# describe ItunesApi do
#   let(:artist_class) { ItunesApi::Music::Artist }
#   let(:store) { :gb }

#   describe '.all_artists_by_name' do
#     subject { described_class.all_artists_by_name(name, store) }

#     let(:name) { 'Pink Floyd' }

#     it 'delegates the search to the Music::Artist class' do
#       expect(artist_class).to receive(:search).with(name, store)

#       subject
#     end
#   end

#   describe '.artist_lookup' do
#     subject { described_class.artist_lookup(apple_id, store) }

#     let(:apple_id) { 999 }

#     it 'delegates the search to the Music::Artist class' do
#       expect(artist_class).to receive(:find_by_apple_id).with(apple_id, store)

#       subject
#     end
#   end
# end
