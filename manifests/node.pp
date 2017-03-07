define dockeragent::node (
  $ensure = present,
  $image = 'puppet/puppet-agent-ubuntu',
  $masterip = $::ipaddress_docker0,
  $command = 'agent --verbose --no-daemonize --summarize',
) {

  require dockeragent

  docker::run { $title:
    ensure           => $ensure,
    hostname         => $title,
    image            => $image,
    command          => $command,
    extra_parameters => [
      "--add-host \"puppet:${masterip}\"",
      #      '--restart=always',
    ]

  }


}
