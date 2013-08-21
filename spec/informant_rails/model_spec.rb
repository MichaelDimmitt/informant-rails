require 'spec_helper'

describe InformantRails::Model do
  let(:user) { User.new(name: 'a').tap(&:valid?) }
  let(:model) { InformantRails::Model.new(user) }

  describe '#initialize' do
    let(:email_error) { model.errors.first }
    let(:name_error) { model.errors.last }

    it 'grabs the name of the model' do
      expect(model.name).to eq('User')
    end

    it 'stores the model errors' do
      expect(model.errors.length).to eq(2)

      expect(email_error.name).to eq('email')
      expect(email_error.value).to be_nil
      expect(email_error.message).to eq("can't be blank")

      expect(name_error.name).to eq('name')
      expect(name_error.value).to eq('a')
      expect(name_error.message).to eq("is too short (minimum is 2 characters)")
    end
  end
end
