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

  class { 'kickstandproject::node::precise::database':

  class { 'jenkins::client': }

  file { '/usr/local/jenkins':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    source  => 'puppet:///modules/kickstandproject/jenkins/usr/local/jenkins',
  }

  file { '/var/lib/jenkins/.gitconfig':
    ensure  => file,
    group   => 'jenkins',
    mode    => '0755',
    owner   => 'jenkins',
    require => Class['jenkins::client'],
    source  => 'puppet:///modules/kickstandproject/jenkins/var/lib/jenkins/.gitconfig',
  }

  $packages = [
    'libmysqlclient-dev',
    'libxml2-dev',
    'libxslt1-dev',
    'python-dev',
    'python-pip',
    'rake',
    'redis-server',
    'rubygems',
  ]

  package { $packages:
    ensure => present,
  }

  $pip_packages = [
    'twine',
  ]

  package { $pip_packages:
    ensure   => latest,
    provider => pip,
    require  => Package[$packages],
  }

  package { 'tox':
    ensure   => '1.6.1',
    provider => pip,
    require  => Package[$packages],
  }

  $gem_packages = [
    'puppet-lint',
    'puppetlabs_spec_helper',
  ]

  package { $gem_packages:
    ensure   => latest,
    provider => gem,
    require  => Package[$packages],
  }
}

# vim:sw=2:ts=2:expandtab
