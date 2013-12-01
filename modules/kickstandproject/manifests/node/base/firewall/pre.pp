#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::firewall::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    action  => 'accept',
    proto   => 'icmp',
  }->
  firewall { '001 accept all to lo interface':
    action  => 'accept',
    iniface => 'lo',
    proto   => 'all',
  }->
  firewall { '002 accept related established rules':
    action => 'accept',
    state  => ['RELATED', 'ESTABLISHED'],
    proto  => 'all',
  }
}

# vim:sw=2:ts=2:expandtab
