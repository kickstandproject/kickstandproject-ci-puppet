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

# vim:sw=2:ts=2:expandtab
