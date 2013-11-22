# == Class: zuul::server::service
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
class zuul::server::service {
  service { $zuul::params::servicename:
    ensure      => running,
    enable      => true,
    hasrestart  => $zuul::params::hasrestart,
    hasstatus   => $zuul::params::hasstatus,
    require     => Class['zuul::server::config'],
    subscribe   => File[$zuul::params::configfile],
  }
}

# vim:sw=2:ts=2:expandtab
