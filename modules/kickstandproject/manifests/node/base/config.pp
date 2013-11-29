#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::config {
  class { 'kickstandproject::node::base::users': }

  realize (
    Kickstandproject::Function::Localuser['pabelanger'],
  )

  file { '/etc/sudoers.d/puppet_conf':
    ensure  => file,
    group   => 'root',
    mode    => '0440',
    owner   => 'root',
    require => Class['sudoers::client'],
    source  => 'puppet:///modules/kickstandproject/base/etc/sudoers.d/puppet_conf',
  }

  class { 'puppet::client':
    options => {
      'server' => 'puppetmaster',
    }
  }
}

# vim:sw=2:ts=2:expandtab
