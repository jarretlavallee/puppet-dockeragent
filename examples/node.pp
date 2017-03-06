include dockeragent

dockeragent::node {'instancename':
    ensure => present,
    masterip => '1.2.3.4',
}
