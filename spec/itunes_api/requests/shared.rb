require 'spec_helper'

RSpec.shared_context 'api_requests', shared_context: :metadata do
  let(:body) { '' }
  let(:headers) do
    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent' => 'Ruby'
    }
  end
  let(:request_url) { 'http://example.com' }

  before do
    WebMock.stub_request(:get, request_url)
           .with(headers: headers)
           .to_return(body: body)
  end
end
