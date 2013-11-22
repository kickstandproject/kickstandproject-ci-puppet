# == Class: zuul::server::config
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
class zuul::server::config {
  file { $zuul::params::configfile:
    ensure  => file,
    content => template('zuul/etc/zuul/zuul.conf.erb'),
    group   => $zuul::params::group,
    mode    => $zuul::params::mode,
    owner   => $zuul::params::owner,
    require => Class['zuul::server::install'],
  }

  user { $zuul::params::owner:
    ensure     => present,
    gid        => $zuul::params::group,
    home       => '/var/lib/zuul',
    managehome => true,
    require    => Group[$zuul::params::group],
    shell      => '/bin/false',
    system     => true,
  }

  group { $zuul::params::group:
    ensure => present,
  }

#  file { $zuul::params::server::defaultfile:
#    ensure  => file,
#    content => template('zuul/etc/default/zuul.erb'),
#    group   => 'root',
#    mode    => '0644',
#    notify  => Class['zuul::server::service'],
#    owner   => 'root',
#  }
}

# vim:sw=2:ts=2:expandtab
