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

    context 'with a nil model' do
      it 'does not process anything' do
        described_class.request.should_not_receive(:process_model)
        described_class.inform(nil)
      end
    end
  end
end
