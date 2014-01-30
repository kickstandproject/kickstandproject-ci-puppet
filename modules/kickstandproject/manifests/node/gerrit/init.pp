#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::gerrit::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::gerrit::bootstrap':
    stage => 'bootstrap',
  }
  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::mod::proxy':
    allow_from => 'all',
  }
  class { 'apache::mod::proxy_http': }
  class { 'mysql::server': }

  mysql::db { 'reviewdb':
    charset  => 'latin1',
    password => 'gerrit',
    user     => 'gerrit2',
  }

  user { 'gerrit2':
    ensure     => present,
    home       => '/home/gerrit2',
    managehome => true,
    shell      => '/bin/bash',
  }

  $proxy_pass = [
    { 'path' => '/', 'url' => 'http://localhost:8080/' },
  ]

  apache::vhost { 'review.kickstand-project.org':
    docroot    => '/var/www/review.kickstand-project.org',
    port       => '80',
    proxy_pass => $proxy_pass,
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }

  firewall { '29418 accept - gerrit':
    action => 'accept',
    port   => '29418',
    proto  => 'tcp',
  }

  file { '/home/gerrit2/acls':
    ensure  => directory,
    group   => 'gerrit2',
    mode    => '0640',
    owner   => 'gerrit2',
    recurse => true,
    require => User['gerrit2'],
    source  => 'puppet:///modules/kickstandproject/gerrit/home/gerrit2/acls',
  }

  file { '/home/gerrit2/review_site':
    ensure  => directory,
    group   => 'gerrit2',
    mode    => '0640',
    owner   => 'gerrit2',
    require => User['gerrit2'],
  }

  file { '/home/gerrit2/review_site/hooks':
    ensure  => directory,
    group   => 'gerrit2',
    mode    => '0755',
    owner   => 'gerrit2',
    require => File['/home/gerrit2/review_site'],
    source  => 'puppet:///modules/kickstandproject/gerrit/home/gerrit2/review_site/hooks',
  }

  file { '/home/gerrit2/projects.yaml':
    ensure  => file,
    content => template('kickstandproject/gerrit/home/gerrit2/projects.yaml.erb'),
    group   => 'gerrit2',
    mode    => '0640',
    notify  => Exec['manage-projects'],
    owner   => 'gerrit2',
    require => User['gerrit2'],
  }

  exec { 'manage-projects':
    command     => 'manage-projects',
    cwd         => '/home/gerrit2',
    refreshonly => true,
    require     => User['gerrit2'],
    user        => 'gerrit2',
  }

  $packages = [
    'libmysqlclient-dev',
    'openjdk-6-jre-headless',
    'python-dev',
    'python-pip',
  ]

  package { $packages:
    ensure => present,
  }

  $pip_packages = [
    'gerritbot',
  ]

  package { $pip_packages:
    ensure   => latest,
    provider => pip,
    require  => Package[$packages],
  }

  package { 'tox':
    ensure   => '1.6.1',
    provider => pip,
    require  => Package[$packages],
  }

  file { '/var/log/gerritbot':
    ensure  => directory,
    group   => 'adm',
    mode    => '0640',
    owner   => 'gerrit2',
    require => User['gerrit2'],
  }

  file { '/etc/gerritbot':
    ensure  => directory,
    group   => 'gerrit2',
    mode    => '0640',
    notify  => Service['gerritbot'],
    owner   => 'gerrit2',
    recurse => true,
    require => User['gerrit2'],
    source  => 'puppet:///modules/kickstandproject/gerrit/etc/gerritbot',
  }

  file { '/etc/init/gerritbot.conf':
    ensure  => file,
    group   => 'root',
    mode    => '0755',
    owner   => 'root',
    source  => 'puppet:///modules/kickstandproject/gerrit/etc/init/gerritbot.conf',
  }

  service { 'gerritbot':
    ensure  => running,
    require => File['/etc/init/gerritbot.conf'],
  }
}

# vim:sw=2:ts=2:expandtab
