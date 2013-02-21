#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::puppet::config {
  vcsrepo { '/opt/kickstandproject-ci-puppet/production':
    ensure   => latest,
    provider => git,
    revision => 'master',
    source   => 'git://github.com/kickstandproject/kickstandproject-ci-puppet.git',
  }

  file { '/tmp/foo':
    ensure => file,
    source => 'puppet:///modules/kickstandproject/foo',
  }
}

# vim:sw=2:ts=2:expandtab
