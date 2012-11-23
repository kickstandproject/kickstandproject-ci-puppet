#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::config {
  jenkins_job_builder::function::template { 'defaults.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/defaults.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'kickstandproject-ci-puppet.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/kickstandproject-ci-puppet.yaml.erb'),
  }

  # TODO: Move into kickstandproject-zuul
  user { 'zuul':
    ensure     => present,
    home       => '/var/lib/zuul',
    managehome => true,
    shell      => '/bin/false',
    system     => true,
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
