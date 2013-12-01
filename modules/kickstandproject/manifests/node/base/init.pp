#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::init {
  class { 'kickstandproject::node::base::bootstrap':
    stage => 'bootstrap',
  }

  class { 'kickstandproject::node::base::config': }

  class { 'firewall': }
  include firewall::post
  include firewall::pre

  firewall { '22 accept - ssh':
    action => 'accept', 
    port   => '22',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
