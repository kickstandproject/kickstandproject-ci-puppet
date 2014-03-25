#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::slave::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::jenkins::slave::bootstrap':
    stage => 'bootstrap',
  }

  realize (
    Kickstandproject::Function::Localuser['jenkins']
  )

  file { '/home/jenkins/.local':
    ensure  => directory,
    group   => 'jenkins',
    mode    => '0755',
    owner   => 'jenkins',
    require => User['jenkins'],
  }

  file { '/home/jenkins/.local/bin':
    ensure  => directory,
    group   => 'jenkins',
    mode    => '0755',
    owner   => 'jenkins',
    recurse => true,
    require => File['/home/jenkins/.local'],
    source  => 'puppet:///modules/kickstandproject/jenkins_slave/home/jenkins/.local/bin',
  }
}

# vim:sw=2:ts=2:expandtab
