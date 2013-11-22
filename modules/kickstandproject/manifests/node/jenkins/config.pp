#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::config {
  file { '/etc/jenkins_jobs/configs':
    ensure  => directory,
    notify  => Exec['jenkins-jobs-update'],
    recurse => true,
    require => Class['jenkins_job_builder::client'],
    source  => 'puppet:///modules/kickstandproject/jenkins/etc/jenkins_jobs/configs',
  }



  # TODO: Move into kickstandproject-gerritbot
  file { '/etc/gerritbot/channels.yaml':
    content => template('kickstandproject/jenkins/etc/gerritbot/channels.yaml.erb'),
    notify  => Service['gerritbot'],
  }

  service { 'gerritbot':
    ensure => running,
  }
}

# vim:sw=2:ts=2:expandtab
