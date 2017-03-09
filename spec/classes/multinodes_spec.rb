require 'spec_helper'
describe 'dockeragent::multinodes' do
  describe 'Without Params' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
          :ipaddress_docker0  => '1.2.3.4',
          })
        end
        it { is_expected.to compile.with_all_deps }
        it { should contain_class('dockeragent::multinodes') }
      end
    end
  end

  describe 'With Params' do
    let(:params) { {
      :ensure      => 'present',
      :masterip    => '1.2.3.4',
      :image       => 'none/none',
      :command     => 'agent -t',
      :prefix      => 'agent-',
      :domain      => 'localdom',
      :agents      => 10,
      :extraparams => ['--restart=always']
    } }
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        it { is_expected.to compile.with_all_deps }
        it { should contain_class('dockeragent::multinodes') }
      end
    end
  end
end
