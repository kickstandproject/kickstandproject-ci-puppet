#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::static::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::static::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::node::static::config': }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
