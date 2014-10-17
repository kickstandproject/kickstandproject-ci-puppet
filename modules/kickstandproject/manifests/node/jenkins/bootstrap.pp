#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::bootstrap {
  apt::function::repository { 'launchpad-pabelanger-zuul':
    components => 'binary/',
    dist       => '',
    key        => 'D50582E6',
    url        => 'pkg.jenkins-ci.org/debian',
  }
}

# vim:sw=2:ts=2:expandtab
