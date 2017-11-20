require 'spec_helper'

RSpec.describe "Model Validation", depends_on: :user_model do
  before { InformantRails::Client.new_request }
  after { InformantRails::Client.cleanup }

  let(:request) { InformantRails::Client.request }
  let(:model) { request.models.first }

  describe "no validation errors" do
    before { User.new(email: 'test@example.com', name: 'Test').valid?  }

    it 'stores the successful validation' do
      expect(model.name).to eq('User')
      expect(model.errors).to be_empty
    end
  end

  describe "standard field validations" do
    before { User.new().valid? }
    let(:email_error) { model.errors.first }
    let(:name_error) { model.errors.last }

    it 'stores the unsuccessful validation' do
      expect(model.name).to eq('User')
      expect(model.errors.length).to eq(2)
    end

    it 'has the correct metadata for the email error' do
      expect(email_error.name).to eq('email')
      expect(email_error.value).to be_nil
      expect(email_error.message).to eq("can't be blank")
    end

    it 'has the correct metadata for the name error' do
      expect(name_error.name).to eq('name')
      expect(name_error.value).to be_nil
      expect(name_error.message).to eq('is too short (minimum is 2 characters)')
    end
  end

  describe "custom base validations" do
    before { User.new(email: 'test@example.com', name: 'Test', add_base_error: true).valid?  }
    let(:base_error) { model.errors.first }

    it 'stores the unsuccessful validation' do
      expect(model.name).to eq('User')
      expect(model.errors.length).to eq(1)
    end

    it 'has the correct metadata for the base error' do
      expect(base_error.name).to eq('base')
      expect(base_error.value).to be_nil
      expect(base_error.message).to eq('This is a base error')
    end
  end
end
