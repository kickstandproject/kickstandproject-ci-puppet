# == Class: zuul::params
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
class zuul::params {
  $configfile = $::operatingsystem ? {
    default => '/etc/zuul/zuul.conf',
  }

  $defaultfile = $::operatingsystem ? {
    default => '/etc/default/zuul',
  }

  $group = $::operatingsystem ? {
    default => 'zuul',
  }

  $hasrestart = $::operatingsystem ? {
    default => true,
  }

  $hasstatus = $::operatingsystem ? {
    default => true,
  }

  $mode = $::operatingsystem ? {
    default => '0644',
  }

  $owner = $::operatingsystem ? {
    default => 'zuul',
  }

  $packagename = $::operatingsystem ? {
    default => 'zuul',
  }

  $servicename = $::operatingsystem ? {
    default => 'zuul',
  }
}

# vim:sw=2:ts=2:expandtab
