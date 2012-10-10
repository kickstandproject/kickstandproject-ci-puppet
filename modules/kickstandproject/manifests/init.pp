#
# kickstandproject: The Kickstand Project
#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::init(
  $environment    = 'production',
  $puppet_server  = 'puppet-01-prod.polybeacon.com'
) {
  class { 'apt::client': }
  class { 'ntp::server': }
  class { 'ssh::server': }
  class { 'sudoers::client': }
  class { 'timezone::client': }

  class { 'puppet::client':
    options => {
      'environment' => $environment,
      'server'      => $puppet_server,
    }
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
