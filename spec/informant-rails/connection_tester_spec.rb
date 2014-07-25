require 'spec_helper'

describe InformantRails::ConnectionTester do
  let(:tester) { described_class.new }

  before do
    InformantRails::Config.api_token = 'abc123'
    expect(tester).to receive(:assistance_message)
  end

  after do
    tester.run
    InformantRails::Client.send(:remove_request)
  end

  context 'missing api token' do
    it 'does not make a request' do
      InformantRails::Config.api_token = nil
      expect(InformantRails::Client).to_not receive(:process)
      expect(tester).to receive(:missing_api_token_message)
    end
  end

  context 'error on the server' do
    it 'displays the error' do
      response = double(success?: false, body: 'Terrible Things')
      expect(InformantRails::Client).to receive(:process).and_return(response)
      expect(tester).to receive(:bad_response_message).with('Terrible Things')
    end
  end

  context 'success' do
    it 'displays a success message' do
      response = double(success?: true)
      expect(InformantRails::Client).to receive(:process).and_return(response)
      expect(tester).to receive(:success_message)
    end
  end
end
