require 'spec_helper'

describe InformantRails::Middleware do
  describe '#call' do
    let(:middleware) { described_class.new(app) }
    let(:app) { double }
    let(:env) { double }
    let(:response) { double }

    it 'wraps the request in an informant transaction' do
      InformantRails::Client.should_receive(:record).with(env)
      app.should_receive(:call).with(env).and_return(response)
      InformantRails::Client.should_receive(:process)
      expect(middleware.call(env)).to eq(response)
    end
  end
end
