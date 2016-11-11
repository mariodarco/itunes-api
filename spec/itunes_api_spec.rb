require 'spec_helper'

describe ItunesApi do
  it 'has a version number' do
    expect(ItunesApi::VERSION).not_to be nil
    expect(ItunesApi.version).not_to be nil
  end
end
