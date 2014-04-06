#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::swap {
  exec { 'Create swap file':
    command => 'dd if=/dev/zero of=/mnt/swap.1 bs=1M count=2048',
    creates => '/mnt/swap.1',
    notify  => Exec['Attach swap file'],
    onlyif  => "test \"${::swapsize_mb}\" = \"0.00\"",
  }

  exec { 'Attach swap file':
    command     => 'mkswap /mnt/swap.1 && swapon /mnt/swap.1',
    refreshonly => true,
  }
}

# vim:sw=2:ts=2:expandtab
