include dockeragent

class {'dockeragent::multinodes':
  masterip => '1.2.3.4',
  agents => 10,
}
