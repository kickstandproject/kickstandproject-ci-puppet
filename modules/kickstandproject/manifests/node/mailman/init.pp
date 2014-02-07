#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::mailman::init(
  $domain = 'lists.kickstand-project.org',
  $password = '',
) {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::mailman::bootstrap':
    stage => 'bootstrap',
  }
  class { 'apache':
    default_vhost => false,
  }

  package { 'mailman':
    ensure => present,
  }

  $aliases = [
    {
      alias => '/pipermail',
      path  => '/var/lib/mailman/archives/public',
    },
    {
      alias => '/images/mailman',
      path  => '/usr/share/images/mailman',
    },
  ]

  $directories = [
    {
      'AllowOverride' => 'None',
      'Allow'         => 'from all',
      'Options'       => 'ExecCGI',
      'Order'         => 'allow,deny',
      'path'          => '/usr/lib/cgi-bin/mailman',
    },
    {
      'AllowOverride' => 'None',
      'Allow'         => 'from all',
      'Options'       => 'FollowSymlinks',
      'Order'         => 'allow,deny',
      'path'          => '/var/lib/mailman/archives/public',
    },
  ]

  apache::vhost { $domain:
    aliases      => $aliases,
    directories  => $directories,
    docroot      => "/var/www/${domain}",
    port         => '80',
    rewrite_rule => '^/$ /cgi-bin/mailman/listinfo [R]',
    scriptalias  => '/usr/lib/cgi-bin',
  }

  file { '/etc/exim4/conf.d':
    ensure  => file,
    group   => 'root',
    mode    => '0644',
    notify  => Service['exim4'],
    owner   => 'root',
    recurse => true,
    require => Package['exim4'],
    source  => 'puppet:///modules/kickstandproject/mailman/etc/exim4/conf.d',
  }

  maillist { 'kickstand':
    ensure      => present,
    admin       => 'paul.belanger@polybeacon.com',
    description => 'Kickstand Project General Mailing List',
    mailserver  => $domain,
    password    => $password,
    webserver   => $domain,
  }

  maillist { 'kickstand-dev':
    ensure      => present,
    admin       => 'paul.belanger@polybeacon.com',
    description => 'Kickstand Project Development Mailing List (not for usage questions)',
    mailserver  => $domain,
    password    => $password,
    webserver   => $domain,
  }
}

# vim:sw=2:ts=2:expandtab
