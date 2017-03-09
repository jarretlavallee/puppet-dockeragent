# Defined Type: dockeragent::node
# ===========================
#
# Defined type `dockeragent::node` will start a docker instance with the given
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
#  it is suggested to run the absolute path to a binary.
#
# * `Array extraparams`
#  Expects a string contaning any additional parameters required to run the instance.
#  an example of this is to have the conatiner always restart with '--restart=always'
#  Defaults to nil
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
# Examples
# --------
#
# @example
#    dockeragent::node { 'exampleagent':
#      image        => 'puppet/puppet-agent-ubuntu',
#      $masterip    => '1.2.3.4'
#      $extraparams => '--restart=always'
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
define dockeragent::node (
  String $ensure = present,
  String $image = hiera('dockeragent::image','puppet/puppet-agent'),
  String $masterip = hiera('dockeragent::masterip', $::ipaddress_docker0),
  String $command = hiera('dockeragent::command', 'agent --verbose --no-daemonize --summarize'),
  Array $extraparams = hiera('dockeragent::extraparams', undef),
) {

  require dockeragent

  $addhost = "--add-host \"puppet:${masterip}\""
  if $extraparams != undef {
    $extra_parameters = concat(
      [$addhost],
      $extraparams
    )
  } else {
    $extra_parameters = [$addhost]
  }

  docker::run { $title:
    ensure           => $ensure,
    hostname         => $title,
    image            => $image,
    command          => $command,
    extra_parameters => $extra_parameters

  }


}
