# == Class: zuul::server::install
#
# === Authors
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
# === Copyright
#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# This program is free software, distributed under the terms
# of the Apache License, Version 2.0. See the LICENSE file at
# the top of the source tree.
#
class zuul::server::install {
#  package { $zuul::params::server::packagename:
#    ensure => present,
#  }
  file { '/etc/zuul':
    ensure => directory,
  }
}

# vim:sw=2:ts=2:expandtab
