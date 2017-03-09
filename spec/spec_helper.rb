require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    :osfamily => 'RedHat',
    :operatingsystem => 'RedHat',
    :operatingsystemmajrelease => '7',
    :operatingsystemrelease => '7.2',
    :kernelversion => '2.6.32',
  }
end
