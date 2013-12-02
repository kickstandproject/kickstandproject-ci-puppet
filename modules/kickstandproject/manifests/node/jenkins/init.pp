#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::jenkins::bootstrap':
    stage => 'bootstrap',
  }
  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::mod::proxy':
    allow_from => 'all',
  }
  class { 'apache::mod::proxy_http': }
  class { 'jenkins::server': }

  $proxy_pass = [
    { 'path' => '/', 'url' => 'http://localhost:8080/' },
  ]

  apache::vhost { 'jenkins.kickstand-project.org':
    docroot    => '/var/www/jenkins.kickstand-project.org',
    port       => '80',
    proxy_pass => $proxy_pass,
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }

  package { 'python-pip':
    ensure => present,
  }

  class { 'jenkins_job_builder::client':
    package => {
      ensure   => '0.6.0',
      provider => 'pip',
    },
    require => Package['python-pip'],
  }

  file { '/etc/jenkins_jobs/configs':
    ensure  => directory,
    notify  => Exec['jenkins-jobs-update'],
    recurse => true,
    require => Class['jenkins_job_builder::client'],
    source  => 'puppet:///modules/kickstandproject/jenkins/etc/jenkins_jobs/configs',
  }
}

# vim:sw=2:ts=2:expandtab
