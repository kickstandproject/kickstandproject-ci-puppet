#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::puppetboard::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::puppetboard::bootstrap':
    stage => 'bootstrap',
  }
}

# vim:sw=2:ts=2:expandtab
