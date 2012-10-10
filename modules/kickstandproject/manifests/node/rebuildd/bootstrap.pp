#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::rebuildd::bootstrap {
  apt::function::repository { 'pabelanger-unstable':
    components  => 'main',
    key         => '6E14C2BE',
    url         => 'ppa.kickstand-project.org/pabelanger/unstable/ubuntu',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
