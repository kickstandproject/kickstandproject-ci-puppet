#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::zuul::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::zuul::bootstrap':
    stage => 'bootstrap',
  }

  class { 'apache': }
  class { 'apache::mod::proxy':
    allow_from => 'all',
  }
  class { 'apache::mod::proxy_http': }

  apache::vhost { 'zuul.kickstand-project.org':
    docroot => '/var/www/zuul.kickstand-project.org',
    port    => '80',
    rewrite_rule => '/status.json$ http://127.0.0.1:8001/status.json [P]',
  }

  package { 'libjs-jquery':
    ensure => present,
  }

  file { '/var/www/zuul.kickstand-project.org/jquery.min.js':
    ensure  => link,
    target  => '/usr/share/javascript/jquery/jquery.min.js',
    require => [
      File['/var/www/zuul.kickstand-project.org'],
      Package['libjs-jquery']
    ],
  }

  user { 'zuul':
    ensure     => present,
    home       => '/var/lib/zuul',
    managehome => true,
    shell      => '/bin/false',
    system     => true,
  }

  file { '/etc/zuul':
    ensure  => directory,
    group   => 'zuul',
    mode    => '0750',
    owner   => 'zuul',
    recurse => true,
    source  => 'puppet:///modules/kickstandproject/zuul/etc/zuul',
    require => User['zuul'],
  }

  file { '/etc/zuul/layout.yaml':
    ensure  => file,
    content => template('kickstandproject/zuul/etc/zuul/layout.yaml.erb'),
    require => File['/etc/zuul'],
  }

  file { '/etc/init/zuul.conf':
    ensure  => file,
    source  => 'puppet:///modules/kickstandproject/zuul/etc/init/zuul.conf',
  }

  service { 'zuul':
    ensure  => running,
    require => File['/etc/init/zuul.conf'],
  }

  firewall { '8001 accept - zuul':
    action => 'accept',
    port   => '8001',
    proto  => 'tcp',
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
