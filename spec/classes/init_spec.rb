require 'spec_helper'
describe 'dockeragent' do
  context 'with default values for all parameters' do
    it { should contain_class('dockeragent') }
  end
end
