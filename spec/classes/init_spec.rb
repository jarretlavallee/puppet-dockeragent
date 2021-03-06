require 'spec_helper'
describe 'dockeragent' do
  let(:title) { 'dockeragent' }
  let(:params) { {
    :image      => 'testimage',
  } }
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to  contain_class('docker') }
      it { should contain_docker__image('testimage') }
    end
  end
end
