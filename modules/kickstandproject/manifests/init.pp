#
# kickstandproject: The Kickstand Project
#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::init() {
  class { 'apt::client': }
  class { 'ntp::server': }
  class { 'ssh::server': }
  class { 'sudoers::client': }
  class { 'timezone::client':
    zone => 'Etc/UTC',
  }

  class { 'kickstandproject::node::base::init': }
}

# vim:sw=2:ts=2:expandtab
