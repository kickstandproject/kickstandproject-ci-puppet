#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::rebuildd::init {
  $network_interfaces = {
    'eth0' => {
      'method'          => 'static',
      'address'         => '209.87.230.44',
      'netmask'         => '255.255.255.248',
      'network'         => '209.87.230.40',
      'broadcast'       => '209.87.230.47',
      'gateway'         => '209.87.230.41',
      'dns-nameservers' => '8.8.8.8',
      'dns-search'      => 'kickstand-project.org',
    },
  }

  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::rebuildd::bootstrap':
    stage => 'bootstrap',
  }

  class { 'network::client':
    interfaces  => $network_interfaces,
  }

  class { 'reprepro::server': }
  class { 'rebuildd::server': }

  reprepro::function::repository { 'pabelanger-unstable-ubuntu':
    name  => 'pabelanger',
    repo  => 'unstable',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
