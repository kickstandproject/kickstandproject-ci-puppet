#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::shell::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::shell::bootstrap':
    stage => 'bootstrap',
  }

  realize (
    Kickstandproject::Function::Localuser['sliske'],
  )

  $packages = [
    'znc',
  ]

  package { $packages:
    ensure => present,
  }

  firewall { '6667 accept - znc':
    action => 'accept',
    port   => '6667',
    proto  => 'tcp',
  }

  firewall { '6668 accept - znc':
    action => 'accept',
    port   => '6668',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
