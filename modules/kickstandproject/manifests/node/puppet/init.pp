#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::puppet::init {
  $network_interfaces = {
    'eth0' => {
      'method'          => 'static',
      'address'         => '209.87.247.148',
      'netmask'         => '255.255.255.240',
      'gateway'         => '209.87.247.145',
      'dns-nameservers' => '8.8.8.8',
      'dns-search'      => 'kickstand-project.org',
    },
  }

  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::puppet::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::node::puppet::config': }

  class { 'network::client':
    interfaces  => $network_interfaces,
  }

  class { 'puppet::server':
    autosign => [
      '*.kickstand-project.org',
    ],
    options  => {
      'manifestdir' => '/opt/kickstandproject-ci-puppet/$environment/manifests',
      'modulepath'  => '/opt/kickstandproject-ci-puppet/$environment/modules:/opt/kickstandproject-ci-puppet/$environment/.modules',
    }
  }
}

# vim:sw=2:ts=2:expandtab
