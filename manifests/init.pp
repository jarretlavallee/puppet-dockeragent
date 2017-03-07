## Requires puppet module install puppetlabs-docker_platform --version 2.1.0
class dockeragent {

  include docker
  docker::image { 'puppet/puppet-agent-ubuntu':
    ensure => present,
  }

}
