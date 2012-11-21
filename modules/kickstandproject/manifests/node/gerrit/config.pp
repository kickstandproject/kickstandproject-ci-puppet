#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::gerrit::config {
  mysql::db { 'reviewdb':
    charset   => 'latin1',
    password  => 'secret',
    user      => 'gerrit2',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
