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

  $packages = [
    'znc',
  ]

  package { $packages:
    ensure => present,
  }
}

# vim:sw=2:ts=2:expandtab
