#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::precise::config {
  class { 'pbuilder::client': }

  pbuilder::function::distribution { 'precise': }
}

# vim:sw=2:ts=2:expandtab
