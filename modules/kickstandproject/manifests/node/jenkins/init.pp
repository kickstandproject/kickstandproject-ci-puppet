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

  apache::vhost { 'jenkins.kickstand-project.org':
    docroot    => '/var/www/jenkins.kickstand-project.org',
    port       => '80',
    proxy_dest => 'http://localhost:8080',
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }

  firewall { '8888 accept - zeromq':
    action => 'accept',
    port   => '8888',
    proto  => 'tcp',
  }

  package { 'python-pip':
    ensure => present,
  }

  $jjb_package = {
    ensure   => '0.6.0',
    provider => 'pip',
  }

  class { 'jenkins_job_builder::client':
    package  => $jjb_package,
    require  => Package['python-pip'],
    settings => {
      'password' => '09933c495f8476a6f021ce7865ad96a8',
    }
  }

  file { '/etc/jenkins_jobs/configs':
    ensure  => directory,
    group   => 'root',
    mode    => '0644',
    notify  => Exec['jenkins-jobs-update'],
    owner   => 'root',
    recurse => true,
    require => Class['jenkins_job_builder::client'],
    source  => 'puppet:///modules/kickstandproject/jenkins/etc/jenkins_jobs/configs',
  }
}

# vim:sw=2:ts=2:expandtab
