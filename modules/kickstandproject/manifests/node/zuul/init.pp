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

  $aliases = [
    {
      aliasmatch => '^/p/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$',
      path       => '/var/lib/zuul/git/$1',
    },
    {
      aliasmatch => '^/p/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$',
      path       => '/var/lib/zuul/git/$1',
    },
  ]

  $rewrites = [
    {
      'rewrite_rule' => '/status.json$ http://127.0.0.1:8001/status.json [P]',
    },
  ]

  $scriptaliases = [
    {
      alias => '/p/',
      path  => '/usr/lib/git-core/git-http-backend/',
    },
  ]

  apache::vhost { 'zuul.kickstand-project.org':
    aliases       => $aliases,
    docroot       => '/var/www/zuul.kickstand-project.org',
    port          => '80',
    rewrites      => $rewrites,
    setenv        => [
      'GIT_PROJECT_ROOT /var/lib/zuul/git/',
      'GIT_HTTP_EXPORT_ALL',
    ],
    scriptaliases => $scriptaliases,
  }

  $packages = [
    'libjs-jquery',
    'python-pip',
  ]

  package { $packages:
    ensure => present,
  }

  package { 'zuul':
    ensure   => '2.0.0',
    provider => pip,
    require  => Package[$packages],
  }

  file { '/var/www/zuul.kickstand-project.org/jquery.min.js':
    ensure  => link,
    target  => '/usr/share/javascript/jquery/jquery.min.js',
    require => [
      File['/var/www/zuul.kickstand-project.org'],
      Package['libjs-jquery']
    ],
  }

  vcsrepo { '/opt/jquery-visibility':
    ensure   => latest,
    provider => git,
    revision => 'master',
    source   => 'https://github.com/mathiasbynens/jquery-visibility.git',
  }

  file { '/var/www/zuul.kickstand-project.org/jquery-visibility.min.js':
    ensure  => link,
    target  => '/opt/jquery-visibility/jquery-visibility.js',
    require => [
      File['/var/www/zuul.kickstand-project.org'],
      Vcsrepo['/opt/jquery-visibility']
    ],
  }

  user { 'zuul':
    ensure     => present,
    home       => '/var/lib/zuul',
    managehome => true,
    shell      => '/bin/bash',
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
    notify  => Service['zuul'],
    require => File['/etc/zuul'],
  }

  file { '/etc/default/zuul':
    ensure => file,
    group  => 'root',
    mode   => '0644',
    notify => File['/etc/init/zuul.conf'],
    owner  => 'root',
    source => 'puppet:///modules/kickstandproject/zuul/etc/default/zuul',
  }

  file { '/etc/init/zuul.conf':
    ensure  => file,
    group   => 'root',
    mode    => '0644',
    notify  => Service['zuul'],
    owner   => 'root',
    require => File['/etc/default/zuul'],
    source  => 'puppet:///modules/kickstandproject/zuul/etc/init/zuul.conf',
  }

  service { 'zuul':
    ensure  => running,
    require => File['/etc/init/zuul.conf'],
  }

  firewall { '4730 accept - gearman':
    action => 'accept',
    port   => '4730',
    proto  => 'tcp',
  }

  firewall { '8001 accept - zuul':
    action => 'accept',
    port   => '8001',
    proto  => 'tcp',
  }

  firewall { '8888 accept - zmq':
    action => 'accept',
    port   => '8888',
    proto  => 'tcp',
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
