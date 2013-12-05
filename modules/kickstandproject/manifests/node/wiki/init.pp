#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::wiki::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::wiki::bootstrap':
    stage => 'bootstrap',
  }

  $packages = [
    'python-moinmoin',
    'python-openid',
  ]

  package { $packages:
    ensure => present,
  }

  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::mod::wsgi':
  }

  apache::vhost { 'wiki.kickstand-project.org':
    docroot      => '/var/www/wiki.kickstand-project.org',
    port         => '80',
    require      => Package[$packages],
    wsgi_daemon_process => 'wsgi',
    wsgi_daemon_process_options =>
        { processes => '2', threads => '15' },
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases => { '/' => '/usr/share/moin/server/moin.wsgi' },
  }

  file { '/etc/moin/mywiki.py':
    ensure  => file,
    group   => 'www-data',
    mode    => '0644',
    notify  => Class['apache::service'],
    owner   => 'www-data',
    source  => 'puppet:///modules/kickstandproject/wiki/etc/moin/mywiki.py',
    require => [
      Class['apache'],
      Package[$packages],
    ],
  }
}

# vim:sw=2:ts=2:expandtab
