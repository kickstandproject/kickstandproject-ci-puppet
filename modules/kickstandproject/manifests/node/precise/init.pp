#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::precise::init {
  $network_interfaces = {
    'eth0' => {
      'method'          => 'static',
      'address'         => '209.87.247.150',
      'netmask'         => '255.255.255.240',
      'gateway'         => '209.87.247.145',
      'dns-nameservers' => '8.8.8.8',
      'dns-search'      => 'kickstand-project.org',
    },
  }

  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::precise::bootstrap':
    stage => 'bootstrap',
  }

  class { 'network::client':
    interfaces  => $network_interfaces,
  }

  class { 'jenkins::client': }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
