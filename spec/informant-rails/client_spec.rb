require 'spec_helper'

describe InformantRails::Client do
  describe '.record' do
    let(:request) { described_class.request }
    let(:env) do
      Hash[
        'HTTP_REFERER' => 'http://example.com/some/url',
        'REQUEST_METHOD' => 'POST'
      ]
    end

    it 'stores the referring url' do
      described_class.record(env)
      expect(request.request_url).to eq 'http://example.com/some/url'
    end

    it 'does not create the request wrapper for GET requests' do
      env['REQUEST_METHOD'] = 'GET'
      described_class.record(env)
      expect(request).to be_nil
    end
  end

  describe '.record_validated_model' do
    before { described_class.record({}) }

    context 'with an excluded model' do
      let(:model) { User.new }
      before { InformantRails::Config.exclude_models = %w(User) }
      after { InformantRails::Config.exclude_models = [] }
      it 'does not process the model' do
        expect(described_class.request).to_not receive(:process_model)
        described_class.record_validated_model(model)
      end
    end

    context 'within a request transaction' do
      let(:model) { double }
      it 'processes the model' do
        expect(described_class.request).to receive(:process_model).with(model)
        described_class.record_validated_model(model)
      end
    end

    context 'without a request transaction' do
      it 'does not process anything' do
        described_class.cleanup
        expect_any_instance_of(InformantRails::Request).to_not receive(:process_model)
        described_class.record_validated_model(double)
      end
    end
  end

  describe '.transmit' do
    let(:model) { User.new.tap(&:save) }
    let(:uri) { URI("https://collector-api.informantapp.com/api/v1/form_submissions") }
    let(:net_http) { double }
    before do
      described_class.record({})
      described_class.record_validated_model(model)
    end

    it 'sends the data to the informant' do
      expect(Net::HTTP).to receive(:start).with(
        'collector-api.informantapp.com', uri.port, use_ssl: true
      ).and_return(net_http)

      described_class.transmit(described_class.request)
    end
  end

  describe '.net_http_post_request' do
    let(:uri) { URI("https://collector-api.informantapp.com/api/v1/form_submissions") }
    let(:net_http_post) { double }

    it 'prepares the post request' do
      expect(Net::HTTP::Post).to receive(:new).with(uri, {
        "Authorization" => "Token token=\"abc123\"",
        "Content-Type" => "application/json"
      }).and_return(net_http_post)

      expect(net_http_post).to receive(:body=).with(
        { payload: described_class.request }.to_json
      )

      described_class.send(:net_http_post_request, described_class.request)
    end
  end

  describe '.process' do
    let(:request) { described_class.request }
    let(:model) { User.new.tap(&:save) }

    context 'with an api token' do
      before do
        described_class.record({})
        described_class.record_validated_model(model)
      end

      context 'and errors present' do
        it 'sends the data to the informant' do
          expect(Thread).to receive(:new)
          described_class.process
        end

        it 'removes the request transaction from the cache' do
          described_class.process
          expect(described_class.request).to be_nil
        end
      end
    end
  end
end
