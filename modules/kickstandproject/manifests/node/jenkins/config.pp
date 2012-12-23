#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::config {
  jenkins_job_builder::function::template { 'defaults.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/defaults.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'macros.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/macros.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'projects.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/projects.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'puppet-jobs.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/puppet-jobs.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'pypi-jobs.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/pypi-jobs.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'python-jobs.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/python-jobs.yaml.erb'),
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
}

# vim:sw=2:ts=2:expandtab
