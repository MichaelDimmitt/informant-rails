require 'spec_helper'

describe InformantRails::Client do
  describe '.record' do
    let(:request) { described_class.request }
    let(:env) { Hash['HTTP_REFERER' => 'http://example.com/some/url'] }
    before { described_class.record(env) }
    it 'stores the referring url' do
      expect(request.request_url).to eq 'http://example.com/some/url'
    end
  end
end
