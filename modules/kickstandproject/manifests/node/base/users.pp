#
# Copyright (C) 2012-2013, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::users {
  @kickstandproject::function::localuser { 'pabelanger':
    email    => 'paul.belanger@polybeacon.com',
    realname => 'Paul Belanger',
    sshkeys  => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAv0YOn34s5fMC/VTw6tn2Js/7jXqWzee9Kbf4NNJ+WiBZ7rtV0F2Jhz9OjfRdja7d8X3M01NFoufPJm5hpMEAvguxSoL0/lm44dcZ7QKT9tfmreAXIbc/2yBEMb7F+ljDldjDmR8Y6+UvTReRoO4lhvYgppH8E2Yo6g+UtS3710u5wqUwl0B5CZmT0j4FbQCMJp4KuscI6zFbuipVw8I10kXv6G/xaIWt/ZdIJRpFo9NVsDreUEeZoi6aRg2YisdzGFcJawy3OKgRh9WyZ7R+lPdvtTAqOnX6m6CS2I4LM3+xuTegiOEPzMCYY7UGx8nKNPQXzBEtGAegfQMwMP+MUQ== paul.belanger@polybeacon.com\n",
  }

@kickstandproject::function::localuser { 'sliske':
    email    => 'sarah.liske@polybeacon.com',
    realname => 'Sarah Liske',
    sshkeys  => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeS01XbdIviWJxreshiBnyVfHWvGo2Wtb+BGS1rPgi5lE7/ciUTCBHdcdECZ2FvziPnLibHwvoMOpqtVw2ZigBQE877WAtCPICgtQFSApj482cdBYGtmyIlgzBgc8ZXe6QmZCYAWLnaXGFch+BnIXgQjo4OagkjoNqgbQvWAwqBfzUgwP7mgWPT0fmunHQ2UvtLBm3nSNpWSrJedeRlPuSuxE5hP+mYZ77PmqgxKVCyUR/uYFMx2YvM4AS3wIoOb8YLw9T13iIEHw1ws5zO4nvHkzhUvwF5Uw5sFpe8jM25pXgZni+kbxiYE9+XFBSWIefMZ4BUQp+Dm/OaKYSNZAV sarah.liske@polybeacon.com\n",
  }
}

# vim:sw=2:ts=2:expandtab
