# == Class: zuul::server::init
#
# === Authors
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
# === Copyright
#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# This program is free software, distributed under the terms
# of the Apache License, Version 2.0. See the LICENSE file at
# the top of the source tree.
#
class zuul::server::init {
  include zuul::server::install
  include zuul::server::config
  include zuul::server::service
}

# vim:sw=2:ts=2:expandtab
