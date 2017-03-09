# Class: dockeragent
# ===========================
#
# Installs docker and ensure the puppet/puppet-agent-ubuntu image is 
# present on the node. 
#
# Parameters
# ----------
# * `String image` 
#  Expects a image name that is accessible by the default repo 
#  for puppetlabs-docker_platform, dockerhub. This defaults to
#  'puppet/puppet-agent' and can be referenced in Hiera by dockeragent::image
#
# Variables
# ----------
#
# * `dockeragent::image`
#  The parameter `image` can be passed in through Hiera as a string.
#
# Examples
# --------
#
# @example
#    class { 'agent':
#      image => 'puppet/puppet-agent-ubuntu',
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
class dockeragent (
  String $image = 'puppet/puppet-agent'
){

  include docker
  docker::image { $image:
    ensure => present,
  }

}
