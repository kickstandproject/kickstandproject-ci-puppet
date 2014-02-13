#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::firewall::post {
  firewall { '998 drop all':
    action => 'drop',
    before => undef,
    proto  => 'all',
  }
}

# vim:sw=2:ts=2:expandtab
