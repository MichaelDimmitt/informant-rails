require 'spec_helper'

describe InformantRails::FieldError do
  describe '#value' do
    subject { field_error.value }
    let(:field_error) { InformantRails::FieldError.new(field_name, 'my value') }

    context 'for a filtered attribute' do
      context 'partial match' do
        let(:field_name) { 'password_confirmation' }
        it { should == '[FILTERED]' }
      end

      context 'exact match' do
        let(:field_name) { 'password' }
        it { should == '[FILTERED]' }
      end
    end

    context 'for an unfiltered attribute' do
      let(:field_name) { 'name' }
      it { should == 'my value' }
    end
  end
end
