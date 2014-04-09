#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::graphite::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::graphite::bootstrap':
    stage => 'bootstrap',
  }

  $packages = [
    'libcairo2-dev',
    'nodejs',
    'python-cairo',
    'python-dev',
    'python-django',
    'python-django-tagging',
    'python-pip',
  ]

  package { $packages:
    ensure => present,
  }

  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::mod::wsgi':
  }

  $aliases = [
    {
      'alias' => '/content',
      'path'  => '/var/lib/graphite/webapp/content/',
    },
  ]

  apache::vhost { 'graphite.kickstand-project.org':
    aliases                     => $aliases,
    docroot                     => '/var/www/graphite.kickstand-project.org',
    port                        => '80',
    require                     => Package[$packages],
    wsgi_daemon_process         => 'wsgi',
    wsgi_daemon_process_options => {
      processes => '2',
      threads   => '15',
    },
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases         => {
      '/' => '/etc/graphite/graphite.wsgi'
    },
  }

  file { '/etc/statsd':
    ensure  => directory,
    group   => 'statsd',
    mode    => '0640',
    owner   => 'statsd',
    recurse => true,
    require => User['statsd'],
    source  => 'puppet:///modules/kickstandproject/graphite/etc/statsd'
  }

  file { '/var/log/graphite':
    ensure  => directory,
    group   => 'adm',
    mode    => '0644',
    owner   => 'www-data',
    require => Class['apache'],
  }

  file { '/etc/graphite':
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    recurse => true,
    source  => 'puppet:///modules/kickstandproject/graphite/etc/graphite'
  }

  file { '/etc/graphite/graphite.wsgi':
    ensure  => file,
    content => template('kickstandproject/graphite/etc/graphite/graphite.wsgi.erb'),
    group   => 'root',
    mode    => '0444',
    owner   => 'root',
    require => File['/etc/graphite'],
  }

  file { '/var/lib/graphite':
    ensure  => directory,
  }

  file { '/usr/local/lib/python2.7/dist-packages/graphite/local_settings.py':
    ensure  => file,
    content => template('kickstandproject/graphite/local_settings.py.erb'),
    mode    => '0444',
    require => Exec['install_graphite_web'],
  }

  file { '/var/lib/graphite/storage':
    ensure  => directory,
    group   => 'www-data',
    owner   => 'www-data',
    recurse => true,
    require => [
      Class['apache'],
      File['/var/lib/graphite'],
    ],
  }

  file { '/usr/local/bin/graphite-init-db.py':
    group  => 'root',
    mode   => '0755',
    owner  => 'root',
    source => 'puppet:///modules/kickstandproject/graphite/usr/local/bin/graphite-init-db.py'
  }

  user { 'statsd':
    ensure     => present,
    home       => '/home/statsd',
    managehome => true,
    shell      => '/bin/bash',
  }

  vcsrepo { '/opt/carbon':
    ensure   => latest,
    provider => git,
    revision => '0.9.x',
    source   => 'https://github.com/graphite-project/carbon.git',
  }

  vcsrepo { '/opt/graphite-web':
    ensure   => latest,
    provider => git,
    # pin version because of https://github.com/graphite-project/graphite-web/issues/650
    revision => '7f8c33da809e2938df55c1ff57ab5329d8d7b878',
    source   => 'https://github.com/graphite-project/graphite-web.git',
  }

  vcsrepo { '/opt/statsd':
    ensure   => latest,
    provider => git,
    revision => 'v0.6.0',
    source   => 'https://github.com/etsy/statsd.git',
  }

  vcsrepo { '/opt/whisper':
    ensure   => latest,
    provider => git,
    revision => '0.9.x',
    source   => 'https://github.com/graphite-project/whisper.git',
  }

  exec { 'install_carbon' :
    command     => 'pip install --install-option="--install-scripts=/usr/local/bin" --install-option="--install-lib=/usr/local/lib/python2.7/dist-packages" --install-option="--install-data=/var/lib/graphite" /opt/carbon',
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/carbon'],
    require     => [
      Exec['install_whisper'],
      File['/var/lib/graphite/storage'],
    ],
  }

  exec { 'install_graphite_web' :
    command     => 'pip install --install-option="--install-scripts=/usr/local/bin" --install-option="--install-lib=/usr/local/lib/python2.7/dist-packages" --install-option="--install-data=/var/lib/graphite" /opt/graphite-web',
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/graphite-web'],
    require     => [
      Exec['install_carbon'],
      File['/var/lib/graphite/storage'],
    ],
  }

  exec { 'install_whisper' :
    command     => 'pip install /opt/whisper',
    refreshonly => true,
    require     => Package[$packages],
    subscribe   => Vcsrepo['/opt/whisper'],
  }

  file { '/etc/init.d/carbon-cache':
    ensure => file,
    group  => 'root',
    mode   => '0555',
    owner  => 'root',
    source => 'puppet:///modules/kickstandproject/graphite/etc/init.d/carbon-cache',
  }

  file { '/etc/init/statsd.conf':
    ensure => file,
    group  => 'root',
    mode   => '0644',
    owner  => 'root',
    source => 'puppet:///modules/kickstandproject/graphite/etc/init/statsd.conf',
  }

  service { 'statsd':
    ensure  => running,
    require => File['/etc/init/statsd.conf'],
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }

  firewall { '8125 accept - statsd':
    action => 'accept',
    port   => '8125',
    proto  => 'udp',
  }
}

# vim:sw=2:ts=2:expandtab
