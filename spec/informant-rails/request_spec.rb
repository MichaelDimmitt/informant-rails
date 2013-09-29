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

  describe '#as_json' do
    subject { request.as_json }
    let(:model) { User.new(name: 'a').tap(&:valid?) }
    before do
      request.request_url = 'example.com/somewhere'
      request.filename = 'UsersController'
      request.action = 'create'
      request.process_model(model)
    end
    it do
      should == {
        models: [{
          name: 'User',
          errors: [
            { name: 'email', value: nil, message: "can't be blank" },
            { name: 'name', value: 'a', message: "is too short (minimum is 2 characters)" }
          ]
        }],
        request_url: 'example.com/somewhere',
        filename: 'UsersController',
        action: 'create'
      }
    end
  end
end
