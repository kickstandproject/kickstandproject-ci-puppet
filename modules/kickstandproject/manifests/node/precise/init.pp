#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::precise::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::precise::bootstrap':
    stage => 'bootstrap',
  }

  class { 'jenkins::client': }

  file { '/usr/local/jenkins':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    source  => 'puppet:///modules/kickstandproject/jenkins/usr/local/jenkins',
  }

  $packages = [
    'python-dev',
    'python-pip',
    'redis-server',
  ]

  package { $packages:
    ensure => present,
  }

  $pip_packages = [
    'tox',
  ]

  package { $pip_packages:
    ensure   => latest,
    provider => pip,
    require  => Package[$packages],
  }
}

# vim:sw=2:ts=2:expandtab
