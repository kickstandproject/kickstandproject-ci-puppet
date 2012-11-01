#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::config {
  file { "${jenkins_job_builder::params::configdir}/defaults.yaml":
    ensure  => file,
    content =>
      template('kickstandproject/jenkins/etc/jenkins_jobs/configs/defaults.yaml.erb'),
    notify  => Exec['jenkins-jobs-update']
    require => Class['jenkins_job_builder::client],
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
