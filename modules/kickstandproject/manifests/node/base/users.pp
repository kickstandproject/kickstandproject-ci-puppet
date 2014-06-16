#
# Copyright (C) 2012-2014, PolyBeacon, Inc.
#
# Paul Belanger <paul.belanger@polybeacon.com>
#
class kickstandproject::node::base::users {
  @kickstandproject::function::localuser { 'jenkins':
    email    => 'jenkins@kickstand-project.org',
    realname => 'Kickstand Project Jenkins',
    sshkeys  => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjXspN+qwE/4RK28JBIIMFH2V3f88bfomqYkw0ovJBwZb4TA2E1CpogYvSo1wU6ntkq7oiK9rKExmTp22VhkniW2BnlAatmHpIr7dB4WhOw0WgX6KhnjdfL/jcVIoDB18IfadYBP51f3BVoWv4736XiRke3u/GABsdyMVbATVy4wNgyrPMKqPBqnF6KxwBdvdDA3nNJcNpqbO+OtYOyi67AExSe4PQMEon7zsLq1EoQEuro75w2H7yqkT+GJm1MQMyAgUmkUZq7Olp8H7NsYcWjUaCpDRtqis/UFVnfmCR94jbWPVzIPPa+/ZMVd6ypbvUCBHNUJjKrDrSU5PKs1O9 jenkins@kickstand-project.org\n",
  }

  @kickstandproject::function::localuser { 'lmadsen':
    email    => 'leif@leifmadsen.com',
    realname => 'Leif Madsen',
    sshkeys  => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYEwbUhR2dF584iu6lRtQv64YleT811R0U0gdBbzsSMzOtDA2cOHqAEBOm4jHTA373Q4VYZvE8YIiyA1LJHHm7oOLdTd/lYiYNkr47cE5LDQQLd8J2T0U8Wih2dp6eZrjUHM+SYerqxoP0BXXDseEfOAiaOrrTLwOV+4q+VvCX37CP7978d8trhQVAMzmbsn0GVdog52fU76HdENREU9SuzYft6VVE3jEa9VTjDASDJ65Y8lsal82JeD1eeMQPxmzGJtap4eDWMrN95EWGmcterdNGg0gfxIVjKoK3ij9JdweUEyxOdrZiawT0DkPhWhUIv4aPireSyIu7dvmuqO6/ leif@leifmadsen.com\n",
  }

  @kickstandproject::function::localuser { 'pabelanger':
    email    => 'paul.belanger@polybeacon.com',
    realname => 'Paul Belanger',
    sshkeys  => "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAv0YOn34s5fMC/VTw6tn2Js/7jXqWzee9Kbf4NNJ+WiBZ7rtV0F2Jhz9OjfRdja7d8X3M01NFoufPJm5hpMEAvguxSoL0/lm44dcZ7QKT9tfmreAXIbc/2yBEMb7F+ljDldjDmR8Y6+UvTReRoO4lhvYgppH8E2Yo6g+UtS3710u5wqUwl0B5CZmT0j4FbQCMJp4KuscI6zFbuipVw8I10kXv6G/xaIWt/ZdIJRpFo9NVsDreUEeZoi6aRg2YisdzGFcJawy3OKgRh9WyZ7R+lPdvtTAqOnX6m6CS2I4LM3+xuTegiOEPzMCYY7UGx8nKNPQXzBEtGAegfQMwMP+MUQ== paul.belanger@polybeacon.com\n",
  }

@kickstandproject::function::localuser { 'sliske':
    email    => 'sarah.liske@polybeacon.com',
    realname => 'Sarah Liske',
    sshkeys  => '',
  }
}

# vim:sw=2:ts=2:expandtab
