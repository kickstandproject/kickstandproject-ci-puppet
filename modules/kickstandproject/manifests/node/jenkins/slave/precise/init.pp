#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::slave::precise::init {
  class { 'kickstandproject::node::jenkins::slave::init': }

  class { 'kickstandproject::node::jenkins::slave::precise::bootstrap':
    stage => 'bootstrap',
  }

  package { 'openjdk-6-jre':
    ensure => present,
  }
}

# vim:sw=2:ts=2:expandtab
