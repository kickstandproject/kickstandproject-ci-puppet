#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::config {
  file { "${jenkins_job_builder::params::configdir}/defaults.yaml":
    ensure  => file,
    require => Class['jenkins_job_builder::client'],
    source  => 'puppet:///node/jenkins/etc/jenkins_jobs/configs/defaults.yaml',
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
