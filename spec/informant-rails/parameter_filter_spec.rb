require 'spec_helper'

describe InformantRails::ParameterFilter do

  describe '.filter' do
    subject { described_class.filter(name, value) }
    let(:name) { 'my_field' }
    let(:value) { 'my_value' }

    before { described_class.instance_variable_set("@matcher", nil) }

    context 'with value tracking disabled' do
      before { InformantRails::Config.value_tracking = false }
      after { InformantRails::Config.value_tracking = true }

      context 'and a value present' do
        it { should == '[FILTERED]' }
      end

      context 'and no value present' do
        let(:value) { nil }
        it { should == '[FILTERED]' }
      end
    end

    context 'with value tracking enabled' do

      context 'and a matching field level filter' do
        before { InformantRails::Config.filter_parameters << 'my_field' }
        after { InformantRails::Config.filter_parameters = [] }
        it { should == '[FILTERED]' }
      end

      context 'and no matching field level filter' do
        before { InformantRails::Config.filter_parameters << 'other_field' }
        after { InformantRails::Config.filter_parameters = [] }
        it { should == value }
      end

      context 'and no field level filters at all' do
        it { should == value }
      end

      context 'and no value present' do
        let(:value) { nil }
        it { should == value }
      end

    end
  end

end
