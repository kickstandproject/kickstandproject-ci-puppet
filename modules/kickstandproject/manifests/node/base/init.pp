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
  class { 'kickstandproject::node::base::swap': }

  class { 'firewall': }
  include firewall::post
  include firewall::pre

  firewall { '22 accept - ssh':
    action => 'accept',
    port   => '22',
    proto  => 'tcp',
  }

  $packages = [
    'exim4',
  ]

  package { $packages:
    ensure => present,
  }

  service { 'exim4':
    ensure  => running,
    require => Package['exim4'],
  }
}

# vim:sw=2:ts=2:expandtab
