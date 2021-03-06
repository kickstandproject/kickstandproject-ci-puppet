#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::slave::precise::bare::init {
  class { 'kickstandproject::node::jenkins::slave::precise::init': }

  class { 'kickstandproject::node::jenkins::slave::precise::bare::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::node::jenkins::slave::precise::bare::database': }

  $packages = [
    'libffi-dev',
    'libmysqlclient-dev',
    'libpq-dev',
    'libxml2-dev',
    'libxslt1-dev',
    'python-dev',
    'python-pip',
    'rabbitmq-server',
    'redis-server',
    'rubygems',
  ]

  package { $packages:
    ensure => present,
  }

  package { 'tox':
    ensure   => '1.6.1',
    provider => pip,
    require  => Package['python-pip'],
  }

  $gem_packages = [
    'puppet-lint',
    'puppetlabs_spec_helper',
  ]

  # TODO(pabelanger): Workaround Error installing puppetlabs_spec_helper:
  #                              rake requires Ruby version >= 1.9.
  package { 'rake':
    ensure   => '10.1.1',
    provider => gem,
    before   => Package['puppetlabs_spec_helper'],
    require  => Package['rubygems'],
  }

  package { $gem_packages:
    ensure   => latest,
    provider => gem,
    require  => Package['rubygems'],
  }
}

# vim:sw=2:ts=2:expandtab
