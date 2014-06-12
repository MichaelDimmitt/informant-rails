require 'spec_helper'

describe InformantRails::Middleware do
  describe '#call' do
    let(:middleware) { described_class.new(app) }
    let(:app) { double }
    let(:env) { double }
    let(:response) { double }

    it 'wraps the request in an informant transaction' do
      expect(InformantRails::Client).to receive(:record).with(env)
      expect(app).to receive(:call).with(env).and_return(response)
      expect(InformantRails::Client).to receive(:process)
      expect(middleware.call(env)).to eq(response)
    end
  end
end
