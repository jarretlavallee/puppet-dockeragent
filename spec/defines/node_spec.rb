require 'spec_helper'
describe 'dockeragent::node' do
  let(:title) { 'testagent' }
  describe 'Without parameters' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
          :ipaddress_docker0  => '1.2.3.4',
          })
        end
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
  describe 'With parameters' do
    let(:params) { {
      :ensure      => 'present',
      :masterip    => '1.2.3.4',
      :image       => 'none/none',
      :command     => 'agent -t',
      :extraparams => ['--restart=always']
    } }
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
