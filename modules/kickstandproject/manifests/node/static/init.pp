#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::static::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::static::bootstrap':
    stage => 'bootstrap',
  }

  class { 'apache': }

  apache::vhost { 'tarballs.kickstand-project.org':
    port    => '80',
    docroot => '/srv/static/tarballs/',
  }
}

# vim:sw=2:ts=2:expandtab
