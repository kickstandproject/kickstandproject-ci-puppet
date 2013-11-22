#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::zuul::config {
  class { 'zuul::server': }

  # TODO: Move this into kickstandproject-zuul
  file { '/etc/zuul/layout.yaml':
    content => template('kickstandproject/zuul/etc/zuul/layout.yaml.erb'),
  }
}

# vim:sw=2:ts=2:expandtab
