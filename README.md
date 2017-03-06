# Docker Puppet Agent

This is a basic repository for a docker agent module that can be spun up for testing multiple agents for reproductions. It is a wrapper for the *puppetlabs-docker_platform* module. The core code leverages a docker image from https://github.com/puppetlabs/puppet-in-docker/master/puppet-agent-ubuntu with the idea of having agents that are deployed through docker.


## Preconfiguration

Puppet Enterprise will automatically configure *pxp-agent* and *MCollective*, which will not work in these containers. It is advised to remove these docker instances from those classifications by adding `virtual != docker` to both *PE Agent* and *PE MCollective* node groups. 

## Starting docker on a node

Either configure classification on the master to use the docker module. Below is an example on how to kickstart a node locally with docker and pull the correct agent image. Use the included dockerhost module in this repo to kickstart the host and download the *puppet/puppet-agent-ubuntu* image. 

```

include dockeragent

```


## Starting a new agent manually

With this module, you should not have to deploy any instances manually, but the following command can be used for testing. 

```

docker run -d --add-host puppet:<Master IP Address> -t puppet/puppet-agent-ubuntu agent --verbose --no-daemonize --summarize

```

## Starting a new agent with puppet code

Leveraging the defined type *dockeragent::node* you can launch a single instance by sending in the **masterip** parameter. More parameters can be seen in the pp file. 

```

include dockeragent

# This will manage a single containerized agent
dockeragent::node {'instancename':
  masterip => '1.2.3.4',
}


```

## Running multiple agents with puppet code

Be careful when starting many agents at once. This can lead to massive IO spikes as there is no logic to stagger the puppet agent runs. If you need many agents to be run (20+) I would suggest incrementally adding more between **puppet agent -t** runs

```

include dockeragent

# This will manage 5 containerized agents
class { 'dockeragent::multinodes':
  masterip => '1.2.3.4',
  agents => 10,
}

```

