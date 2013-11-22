#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::zuul::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::zuul::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::node::zuul::config': }
}

# vim:sw=2:ts=2:expandtab
