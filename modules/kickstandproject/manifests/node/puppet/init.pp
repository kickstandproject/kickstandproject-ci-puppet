#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::puppet::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::puppet::bootstrap':
    stage => 'bootstrap',
  }

  class { 'puppet::server':
    autosign => [
      '*.kickstand-project.org',
    ],
    options  => {
      'manifestdir'          => '/opt/kickstandproject-ci-puppet/$environment/manifests',
      'modulepath'           => '/opt/kickstandproject-ci-puppet/$environment/modules:/opt/kickstandproject-ci-puppet/$environment/.modules',
      'report'               => true,
      'reports'              => 'puppetdb',
      'storeconfigs'         => true,
      'storeconfigs_backend' => 'puppetdb',
     }
   }

  package { 'puppetdb-terminus':
    ensure => true,
  }

  vcsrepo { '/opt/kickstandproject-ci-puppet/production':
    ensure   => latest,
    notify   => Exec['tools/install_modules.sh'],
    provider => git,
    revision => 'master',
    source   => 'git://github.com/kickstandproject/kickstandproject-ci-puppet.git',
  }

  file { '/etc/puppet/puppetdb.conf':
    ensure  => file,
    notify  => Class['puppet::server::service'],
    require => Class['puppet::server'],
    source  => 'puppet:///modules/kickstandproject/puppet/etc/puppet/puppetdb.conf',
  }

  file { '/etc/puppet/hiera.yaml':
    ensure  => file,
    notify  => Class['puppet::server::service'],
    require => Class['puppet::server'],
    source  => 'puppet:///modules/kickstandproject/puppet/etc/puppet/hiera.yaml',
  }

  file { '/var/lib/puppet/reports':
    ensure  => directory,
    group   => 'puppet',
    mode    => '0640',
    owner   => 'puppet',
    recurse => true,
    require => Class['puppet::server'],
  }

  exec { 'tools/install_modules.sh':
    command     => '/bin/sh tools/install_modules.sh',
    cwd         => '/opt/kickstandproject-ci-puppet/production',
    refreshonly => true,
  }
}

# vim:sw=2:ts=2:expandtab
