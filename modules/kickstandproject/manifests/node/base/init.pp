#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::init {
  class { 'kickstandproject::node::base::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::node::base::config': }
}

# vim:sw=2:ts=2:expandtab
