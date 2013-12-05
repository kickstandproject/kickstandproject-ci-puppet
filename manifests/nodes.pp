node 'gerrit-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::gerrit::init': }
}

node 'jenkins-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::jenkins::init': }
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

node 'static-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::static::init': }
}

node 'wiki-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::wiki::init': }
}

node 'zuul-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::zuul::init': }
}

# vim:sw=2:ts=2:expandtab
