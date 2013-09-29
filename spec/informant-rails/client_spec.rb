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

  describe '.inform' do
    context 'with an excluded model' do
      let(:model) { User.new }
      before { InformantRails::Config.exclude_models = %w(User) }
      after { InformantRails::Config.exclude_models = [] }
      it 'does not process the model' do
        described_class.request.should_not_receive(:process_model)
        described_class.inform(model)
      end
    end

    context 'within a request transaction' do
      let(:model) { double }
      it 'processes the model' do
        described_class.request.should_receive(:process_model).with(model)
        described_class.inform(model)
      end
    end

    context 'without a request transaction' do
      it 'does not process anything' do
        described_class.should_receive(:request)
        InformantRails::Request.any_instance.should_not_receive(:process_model)
        described_class.inform(double)
      end
    end
  end

  describe '.process' do
    let(:request) { described_class.request }
    let(:model) { User.new.tap(&:save) }
    before { described_class.record({}) }

    context 'with an api token' do
      before { InformantRails::Config.api_token = 'abc123' }

      context 'and errors present' do
        let(:typhoeus_request) { double }
        before { described_class.inform(model) }

        it 'sends the data to the informant' do
          Typhoeus::Request.should_receive(:new).with(
            described_class.send(:api_url),
            method: :post, params: { payload: request.as_json }
          ).and_return(typhoeus_request)
          typhoeus_request.should_receive(:run)
          described_class.process
        end

        it 'removes the request transaction from the cache' do
          described_class.process
          expect(described_class.request).to be_nil
        end
      end

      context 'without an api token present' do
        it 'sends the data to the informant' do
          Net::HTTP.should_not_receive(:post_form)
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
        Net::HTTP.should_not_receive(:post_form)
        described_class.process
      end

      it 'removes the request transaction from the cache' do
        described_class.process
        expect(described_class.request).to be_nil
      end
    end
  end
end
