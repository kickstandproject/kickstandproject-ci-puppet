#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::init {
  $network_auto = [
    'eth0',
    'eth1',
  ]

  $network_interfaces = {
    'eth0' => {
      'method'          => 'static',
      'address'         => '209.87.247.149',
      'netmask'         => '255.255.255.240',
      'gateway'         => '209.87.247.145',
      'dns-nameservers' => '8.8.8.8',
      'dns-search'      => 'kickstand-project.org',
    },
    'eth1' => {
      'method' => 'dhcp',
    },
  }

  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::jenkins::bootstrap':
    stage => 'bootstrap',
  }

  class { 'network::client':
    auto       => $network_auto,
    interfaces => $network_interfaces,
  }

  class { 'jenkins::server':
    hostname  => 'jenkins.kickstand-project.org',
  }

  # TODO: Add these settings to hiera
  class { 'jenkins_job_builder::client':
    settings => {
      'password' => '09933c495f8476a6f021ce7865ad96a8',
      'url'      => 'http://jenkins.kickstand-project.org',
    }
  }

  class { 'kickstandproject::node::jenkins::config': }
}

# vim:sw=2:ts=2:expandtab
