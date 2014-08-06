require 'spec_helper'

describe InformantRails::Client do
  describe '.record' do
    before { described_class.instance_variable_get('@requests').clear }
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
        described_class.instance_variable_get("@requests").clear
        expect_any_instance_of(InformantRails::Request).to_not receive(:process_model)
        described_class.record_validated_model(double)
      end
    end
  end

  describe '.process' do
    let(:request) { described_class.request }
    let(:model) { User.new.tap(&:save) }
    before { described_class.record({}) }

    context 'with an api token' do
      context 'and errors present' do
        let(:typhoeus_request) { double }
        before { described_class.record_validated_model(model) }

        it 'sends the data to the informant' do
          expect(Typhoeus::Request).to receive(:new).with(
            "https://api.informantapp.com/api/v1/form_submissions",
            method: :post,
            body: { payload: request }.to_json,
            headers: {
              "Authorization" => "Token token=\"abc123\"",
              "Content-Type" => "application/json"
            }
          ).and_return(typhoeus_request)
          expect(typhoeus_request).to receive(:run)
          described_class.process
        end

        it 'removes the request transaction from the cache' do
          described_class.process
          expect(described_class.request).to be_nil
        end
      end

      context 'without an api token present' do
        before { InformantRails::Config.api_token = nil }

        it 'sends the data to the informant' do
          expect(Typhoeus::Request).to_not receive(:new)
          described_class.process
        end

        it 'removes the request transaction from the cache' do
          described_class.process
          expect(described_class.request).to be_nil
        end
      end
    end

    context 'without an api token present' do
      before { InformantRails::Config.api_token = '' }

      it 'sends the data to the informant' do
        expect(Typhoeus::Request).to_not receive(:new)
        described_class.process
      end

      it 'removes the request transaction from the cache' do
        described_class.process
        expect(described_class.request).to be_nil
      end
    end
  end
end
