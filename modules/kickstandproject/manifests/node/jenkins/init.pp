#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::init {
  $network_interfaces = {
    'eth0' => {
      'method'          => 'static',
      'address'         => '209.87.230.45',
      'netmask'         => '255.255.255.248',
      'network'         => '209.87.230.40',
      'broadcast'       => '209.87.230.47',
      'gateway'         => '209.87.230.41',
      'dns-nameservers' => '8.8.8.8',
      'dns-search'      => 'kickstand-project.org',
    },
  }

  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::jenkins::bootstrap':
    stage => 'bootstrap',
  }

  class { 'network::client':
    interfaces  => $network_interfaces,
  }

  class { 'jenkins::server':
    hostname  => 'jenkins.kickstand-project.org',
  }

  class { 'jenkins_job_builder::client': }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
