#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::puppetdb::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::puppetdb::bootstrap':
    stage => 'bootstrap',
  }

  class { 'puppetdb':
    listen_address     => $::ipaddress,
    ssl_listen_address => $::ipaddress,
  }

  firewall { '8080 accept - puppetdb':
    action => 'accept',
    port   => '8080',
    proto  => 'tcp',
  }

  firewall { '8081 accept - puppetdb':
    action => 'accept',
    port   => '8081',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
