import 'nodes.pp'

stage { 'bootstrap':
  before => Stage['main'],
}

Exec {
  path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
}

resources { 'firewall':
  purge => true,
}

Firewall {
  before  => Class['kickstandproject::node::base::firewall::post'],
  require => Class['kickstandproject::node::base::firewall::pre'],
}
