#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::gerrit::config {
  mysql::function::database { 'reviewdb': }

  mysql::function::user { 'gerrit2':
    password => 'secret',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
