#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::bootstrap(
  $stage = 'bootstrap',
) {
  apt::function::repository { 'puppetlabs':
    components => 'main',
    key        => '4BD6EC30',
    require    => File['/etc/apt/preferences.d/00-puppet.pref'],
    url        => 'apt.puppetlabs.com',
  }

  file { '/etc/apt/preferences.d/00-puppet.pref':
    ensure => file,
    mode   => '0644',
    group  => 'root',
    source => 'puppet:///modules/kickstandproject/base/etc/apt/preferences.d/00-puppet.pref',
    owner  => 'root',
  }
}

# vim:sw=2:ts=2:expandtab
