#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::jenkins::init {
  class { 'kickstandproject::init': }

  class { 'kickstandproject::node::jenkins::bootstrap':
    stage => 'bootstrap',
  }
  class { 'apache':
    default_vhost => false,
  }
  class { 'apache::mod::proxy':
    allow_from => 'all',
  }
  class { 'apache::mod::proxy_http': }
  class { 'jenkins::server': }

  $proxy_pass = [
    { 'path' => '/', 'url' => 'http://localhost:8080/' },
  ]

  apache::vhost { 'jenkins.kickstand-project.org':
    docroot    => '/var/www/jenkins.kickstand-project.org',
    port       => '80',
    proxy_pass => $proxy_pass,
  }

  firewall { '80 accept - apache':
    action => 'accept',
    port   => '80',
    proto  => 'tcp',
  }
}

# vim:sw=2:ts=2:expandtab
