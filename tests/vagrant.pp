node default {
  include ::nagios

  case $::operatingsystem {
    'Amazon': {
        Package { allow_virtual => false }
    }
    default: {}
  }

  case $::osfamily {
    'Debian': {

    }
    'RedHat': {

    }
    default: { }
  }
}
