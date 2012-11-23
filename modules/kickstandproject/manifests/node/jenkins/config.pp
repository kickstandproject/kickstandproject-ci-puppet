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

  jenkins_job_builder::function::template { 'macros.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/macros.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'projects.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/projects.yaml.erb'),
  }

  jenkins_job_builder::function::template { 'python-jobs.yaml':
    content => template('kickstandproject/jenkins/etc/jenkins_jobs/configs/python-jobs.yaml.erb'),
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
