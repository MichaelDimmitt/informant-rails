require 'spec_helper'

shared_examples 'save action' do
  context 'with an invalid model' do
    let(:model) { User.new }
    it 'gets called' do
      InformantRails::Client.should receive(:inform).with(model)
      model.public_send(save_action)
    end
  end

  context 'with a valid model' do
    let(:model) { User.new(name: 'Han Solo', email: 'han@starwars.com') }
    it 'does not get called' do
      InformantRails::Client.should_not receive(:inform)
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
      let(:save_action) { :save }
      it_should_behave_like 'save action'
    end

    context '#invalid?' do
      let(:save_action) { :save }
      it_should_behave_like 'save action'
    end
  end
end
