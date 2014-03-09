#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::precise::database {
  class { 'mysql::server':
    config_hash => {
      'root_password' => 'secret',
      'default_engine'=> 'MyISAM',
      'bind_address'  => '127.0.0.1',
    },
  }

  mysql::db { 'kickstand_citest':
    user     => 'kickstand_citest',
    password => 'kickstand_citest',
    host     => 'localhost',
    grant    => ['all'],
    require  => Class['mysql::server'],
  }

  class { 'postgresql::server': }

  postgresql::server::role { 'kickstand_citest':
    password_hash => postgresql_password('kickstand_citest', 'kickstand_citest'),
  }->
  postgresql::server::database { 'kickstand_citest':
    owner => 'kickstand_citest',
  }->
  postgresql::server::database_grant {'kickstand_citest':
    db        => 'kickstand_citest',
    privilege => 'ALL',
    role      => 'kickstand_citest',
  }
}

# vim:sw=2:ts=2:expandtab
