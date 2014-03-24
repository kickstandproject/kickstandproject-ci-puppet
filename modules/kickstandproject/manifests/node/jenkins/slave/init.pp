#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::slave::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::jenkins::slave::bootstrap':
    stage => 'bootstrap',
  }

  realize (
    Kickstandproject::Function::Localuser['nodepool']
  )

  package { 'jenkins-slave':
    ensure => present,
  }
}

# vim:sw=2:ts=2:expandtab
