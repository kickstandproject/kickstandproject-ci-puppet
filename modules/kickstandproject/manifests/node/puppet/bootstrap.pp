#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::puppet::bootstrap(
  $stage = 'bootstrap',
) {
  apt::function::repository { 'puppetlabs':
    components => 'main',
    key        => '4BD6EC30',
    url        => 'apt.puppetlabs.com',
  }
}

# vim:sw=2:ts=2:expandtab
