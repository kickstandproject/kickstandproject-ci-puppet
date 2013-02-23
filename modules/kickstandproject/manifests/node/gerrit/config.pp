#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::gerrit::config {
  class { 'git::client': }

  mysql::db { 'reviewdb':
    charset   => 'latin1',
    password  => hiera('mysql_db_password'),
    user      => 'gerrit2',
  }

  apache::function::virtualhost-proxy { 'review.kickstand-project.org':
    port => '8080',
  }

  # TODO: Move this into gerritx project
  file { '/home/gerrit2/projects.yaml':
    content => template('kickstandproject/gerrit/home/gerrit2/projects.yaml.erb'),
  }
}

# vim:sw=2:ts=2:expandtab
