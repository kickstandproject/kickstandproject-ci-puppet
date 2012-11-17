node 'gerrit-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::precise::init': }
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

node 'rebuildd-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::rebuildd::init': }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
