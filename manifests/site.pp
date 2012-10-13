node 'jenkins-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::jenkins::init': }
}

node 'rebuildd-01-prod.kickstand-project.org' {
  class { 'kickstandproject::node::rebuildd::init': }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
