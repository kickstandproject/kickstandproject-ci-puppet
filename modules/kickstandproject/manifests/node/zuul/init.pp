#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::zuul::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::zuul::bootstrap':
    stage => 'bootstrap',
  }

  user { 'zuul':
    ensure     => present,
    home       => '/var/lib/zuul',
    managehome => true,
    shell      => '/bin/false',
    system     => true,
  }

  file { '/etc/zuul':
    ensure  => directory,
    group   => 'zuul',
    mode    => '0750',
    owner   => 'zuul',
    recurse => true,
    source  => 'puppet:///modules/kickstandproject/zuul/etc/zuul',
    require => User['zuul'],
  }

  file { '/etc/zuul/layout.yaml':
    ensure  => file,
    content => template('kickstandproject/zuul/etc/zuul/layout.yaml.erb'),
    require => File['/etc/zuul'],
  }

  file { '/etc/init/zuul.conf':
    ensure  => file,
    source  => 'puppet:///modules/kickstandproject/zuul/etc/init/zuul.conf',
  }

  service { 'zuul':
    ensure  => running,
    require => File['/etc/init/zuul.conf'],
  }
}

# vim:sw=2:ts=2:expandtab
