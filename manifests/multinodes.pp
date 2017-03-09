# Class: dockeragent::multinodes
# ===========================
#
# Class `dockeragent::multinodes` will start multiple docker instances with the given
# parameters.
#
#
# Parameters
# ----------
# * `String ensure`
#  Expects 'present|absent' to manage the docker instance. Defaults to present.
#
# * `String image`
#  Expects the name of a docker image accessible from dockerhub. Defaults to
#  hiera `dockeragent::image` or 'puppet/puppet-agent'.
#
# * `String masterip`
#  Expects the IP address of the puppet master. This is used to configure host
#  entries in the instance. Defaults to $::ipaddress_docker0 and can be referenced
# in hiera by `dockeragent::masterip`
#
# * `String command`
#  Expects a string of arugments that will be run with the puppet command. The
#  default image has an entrypoint of puppet, but if an alternative image is used
#  it is suggested to run the absolute path to a binary. Can be referenced in Hiera
#  by 'dockeragent::command'
#
# * `Array extraparams`
#  Expects a string contaning any additional parameters required to run the instance.
#  an example of this is to have the conatiner always restart with '--restart=always'
#  Defaults to nil and can be referenced in hiera as 'dockeragent::command'
#
# * `Integer agents`
#  Expects an integer as the number of docker instances to create. Defaults to 5
#  and can be looked up in hiera as 'dockeragent::multinodes::agents'
#
# * `String prefix`
#  Expects a string with the prefix for the hostname of the container instance.
#  defaults to 'agent' and can be referenced in hiera by 'dockeragent::multinodes::prefix'
#  a prefix of agent will come out as agent#.domain.com
#
# * `String domain`
#  Expects a string with the domain for the hostname to be configured on the container.
#  defaults to $::fqdn of the node and can be set in hiera as 'dockeragent::multinodes::domain'
#
# Variables
# ----------
#
# * `dockeragent::image`
#  The parameter `image` can be passed in through Hiera as a string.
#
# * `dockeragent::masterip`
#  The parameter `masterip` can be passed in through Hiera as a string.
#
# * `dockeragent::command`
#  The parameter `command` can be passed in through Hiera as a string.
#
# * `dockeragent::extraparams`
#  The parameter `extraparams` can be passed in through Hiera as an array.
#
# * `dockeragent::agents`
#  The parameter `agents` can be passed in through Hiera as an array.
#
# * `dockeragent::prefix`
#  The parameter `prefix` can be passed in through Hiera as an array.
#
# * `dockeragent::domain`
#  The parameter `domain` can be passed in through Hiera as an array.
#
# Examples
# --------
#
# @example
#    class { 'dockeragent::multinodes':
#      image        => 'puppet/puppet-agent-ubuntu',
#      $masterip    => '1.2.3.4'
#      $extraparams => '--restart=always'
#      $prefix      => 'testagent-'
#      $agents      => 30,
#    }
#
# Authors
# -------
#
# Jarret Lavallee <jarret.lavallee@puppet.com>
#
# Copyright
# ---------
#
# Copyright 2017 Jarret Lavallee, unless otherwise noted.
#
class dockeragent::multinodes (
  String $ensure = present,
  String $image = 'puppet/puppet-agent',
  String $masterip = $::ipaddress_docker0,
  String $command = 'agent --verbose --no-daemonize --summarize',
  Array $extraparams = [],
  Integer $agents =  5,
  String $prefix = 'agent-',
  String $domain = $::fqdn,
  Boolean $remove_container_on_start = false,
) {

  require dockeragent

  range(1,$agents).each |$n| {
    dockeragent::node { "${prefix}${n}.${domain}":
      ensure                    => $ensure,
      masterip                  => $masterip,
      image                     => $image,
      command                   => $command,
      extraparams               => $extraparams,
      remove_container_on_start => $remove_container_on_start,
    }
  }
}
