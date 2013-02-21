#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::config {
  file { '/etc/jenkins_jobs/configs':
    ensure  => directory,
    notify  => Exec['jenkins-jobs-update'],
    require => Class['jenkins_jobs_builder'],
    source  => 'puppet:///modules/kickstandproject/jenkins/etc/jenkins_jobs/configs',
  }

  # TODO: Move into kickstandproject-zuul
  user { 'zuul':
    ensure     => present,
    home       => '/var/lib/zuul',
    managehome => true,
    shell      => '/bin/false',
    system     => true,
  }

  # TODO: Move this into kickstandproject-zuul
  file { '/etc/zuul/layout.yaml':
    content => template('kickstandproject/jenkins/etc/zuul/layout.yaml.erb'),
  }

  # TODO: Move into kickstandproject-gerritbot
  file { '/etc/gerritbot/channels.yaml':
    content => template('kickstandproject/jenkins/etc/gerritbot/channels.yaml.erb'),
  }
}

# vim:sw=2:ts=2:expandtab
