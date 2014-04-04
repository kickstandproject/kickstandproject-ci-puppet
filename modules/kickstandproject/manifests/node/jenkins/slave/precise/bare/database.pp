#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::slave::precise::database {
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
    createdb      => true,
    superuser     => false,
    require       => Class['postgresql::server'],
  }

  postgresql::server::db { 'kickstand_citest':
    user     => 'kickstand_citest',
    password => postgresql_password('kickstand_citest', 'kickstand_citest'),
    grant    => 'all',
    require  => [
      Class['postgresql::server'],
      Postgresql::Server::Role['kickstand_citest'],
    ],
  }

  # Alter the new database giving the test DB user ownership of the DB.
  postgresql_psql { 'ALTER DATABASE kickstand_citest OWNER TO kickstand_citest':
    db          => 'postgres',
    refreshonly => true,
    subscribe   => Postgresql::Server::Db['kickstand_citest'],
  }
}

# vim:sw=2:ts=2:expandtab
