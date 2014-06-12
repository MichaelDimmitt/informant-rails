require 'spec_helper'

shared_examples 'save action' do
  context 'with an invalid model' do
    let(:model) { User.new }
    it 'gets called' do
      InformantRails::Client.should receive(:record_validated_model).with(model)
      model.public_send(save_action)
    end
  end

  context 'with a valid model' do
    let(:model) { User.new(name: 'Han Solo', email: 'han@starwars.com') }
    it 'gets called' do
      InformantRails::Client.should receive(:record_validated_model).with(model)
      model.public_send(save_action)
    end
  end
end

describe InformantRails::Railtie do
  context 'from an ActiveRecord model' do
    context '#save' do
      let(:save_action) { :save }
      it_should_behave_like 'save action'
    end

    context '#valid?' do
      let(:save_action) { :valid? }
      it_should_behave_like 'save action'
    end

    context '#invalid?' do
      let(:save_action) { :invalid? }
      it_should_behave_like 'save action'
    end
  end
end
