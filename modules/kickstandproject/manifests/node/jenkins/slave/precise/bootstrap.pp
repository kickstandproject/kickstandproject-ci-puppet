#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::slave::precise::bootstrap(
  $stage = 'bootstrap',
) {
  class { 'kickstandproject::node::jenkins::slave::bootstrap':
    stage = $stage,
  }
}

# vim:sw=2:ts=2:expandtab
