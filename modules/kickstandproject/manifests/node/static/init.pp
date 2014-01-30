#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::static::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::static::bootstrap':
    stage => 'bootstrap',
  }

  class { 'apache': }

  user { 'captpants':
    ensure     => present,
    home       => '/home/captpants',
    managehome => true,
    shell      => '/bin/bash',
  }

  file { '/srv/static/tarballs':
    ensure  => directory,
    group   => 'captpants',
    mode    => '0644',
    owner   => 'captpants',
    require => User['captpants'],
  }

  apache::vhost { 'tarballs.kickstand-project.org':
    docroot => '/srv/static/tarballs',
    port    => '80',
    require => File['/srv/static/tarballs'],
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
