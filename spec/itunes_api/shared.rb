require 'spec_helper'

RSpec.shared_context 'api_requests', shared_context: :metadata do
  let(:json_data)   { parsed_data.to_json }
  let(:opened_url)  { double(StringIO) }
  let(:url)         { 'https://example.apple.com' }

  before do
    allow(instance).to receive(:url).and_return url
    allow(instance).to receive(:open).with(url).and_return opened_url
    allow(opened_url).to receive(:read).and_return json_data
  end
end
