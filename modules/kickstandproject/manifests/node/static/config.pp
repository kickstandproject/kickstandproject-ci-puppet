#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::static::config {
  require apache::server

  apache::function::virtualhost { 'tarballs.kickstand-project.org':
    docroot => '/srv/static/tarballs',
  }
}

# vim:sw=2:ts=2:expandtab
