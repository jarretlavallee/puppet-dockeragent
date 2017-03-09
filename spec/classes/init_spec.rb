require 'spec_helper'
describe 'dockeragent' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      it { is_expected.to compile.with_all_deps }
      it { should contain_class('dockeragent') }
    end
  end
end
