class dockeragent::multinodes (
  $ensure = present,
  $image = 'puppet/puppet-agent-ubuntu',
  $masterip = $::ipaddress_docker0,
  $command = 'agent --verbose --no-daemonize --summarize',
  $agents = 5,
  $prefix = 'agent',
) {

  require dockeragent

  range(1,$agents).each |$n| {
    dockeragent::node { "${prefix}${n}.${::fqdn}":
      ensure => $ensure,
      masterip => $masterip,
      image => $image,
      command => $command,
    }
  }
}
