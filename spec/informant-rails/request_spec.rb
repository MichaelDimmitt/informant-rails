require 'spec_helper'

describe InformantRails::Request do
  let(:request) { described_class.new }

  describe '#process_model' do
    context 'with a model' do
      let(:model) { User.new(name: 'a') }
      before do
        model.valid?
        request.process_model(model)
      end

      it 'stores the model' do
        expect(request.models.length).to eq(1)
        expect(request.models.first).to be_kind_of(InformantRails::Model)
      end
    end

    context 'without a model' do
      before { request.process_model(nil) }
      it 'does not add the model to the cache' do
        expect(request.models).to be_empty
      end
    end
  end

  describe '#to_json' do
    subject { request.to_json }
    let(:model) { User.new(name: 'a') }
    before do
      request.request_url = 'example.com/somewhere'
      request.filename = 'UsersController'
      request.action = 'create'
      request.process_model(model)
    end
    it do
      should == {
        request_url: 'example.com/somewhere',
        models: [InformantRails::Model.new(model)],
        filename: 'UsersController',
        action: 'create'
      }.to_json
    end
  end
end
