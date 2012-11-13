#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::precise::bootstrap(
  $stage = 'bootstrap',
) {
  apt::function::repository { 'launchpad-pabelanger-zuul':
    components  => 'main',
    key         => '2C9F0613',
    url         => 'ppa.launchpad.net/pabelanger/zuul/ubuntu',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
