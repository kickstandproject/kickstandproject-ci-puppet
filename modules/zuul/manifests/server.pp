# == Class: zuul::server
#
# This class manages the Zuul server
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'zuul::server': }
#
# === Authors
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
# === Copyright
#
# Copyright (C) 2012, PolyBeacon, Inc.
#
# This program is free software, distributed under the terms
# of the Apache License, Version 2.0. See the LICENSE file at
# the top of the source tree.
#
class zuul::server(
  $settings = {},
) {
  $defaults = {
    'jenkins' => {
      'server' => '',
      'user'   => '',
      'apikey' => '',
    },
    'gerrit' => {
      'baseurl' => '',
      'server'  => '',
      'sshkey'  => '',
      'user'    => '',
    },
    'zuul' => {
      'layout_config' => '/etc/zuul/layout.yaml',
      'log_config'    => '/etc/zuul/logging.conf',
      'pidfile'       => '/var/run/zuul/zuul.pid',
    },
  }

  $settings_real = merge($defaults, $settings)

  include zuul::params
  include zuul::server::init
}

# vim:sw=2:ts=2:expandtab
