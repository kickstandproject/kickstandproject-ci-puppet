node 'gerrit-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::gerrit::init': }
}

node 'graphite-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::graphite::init': }
}

node 'jenkins-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::jenkins::init': }
}

node 'mailman-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::mailman::init':
    password => 'CorrectHorseBatteryStaple',
  }
}

node 'precise-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::precise::init': }
}

node 'puppet-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::puppet::init': }
}

node 'puppetboard-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::puppetboard::init': }
}

node 'puppetdb-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::puppetdb::init': }
}

node 'shell-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::shell::init': }
}

node 'static-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::static::init': }
}

node 'wiki-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::wiki::init': }
}

node 'zuul-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::zuul::init': }
}

# grunt-precise-1395681045
node /^grunt-precise-\d+$/ {
  class { 'kickstandproject::init': }
}

# vim:sw=2:ts=2:expandtab
