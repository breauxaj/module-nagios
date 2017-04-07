node default {
  include ::nagios

  case $::osfamily {
    'Debian': {

    }
    'RedHat': {

    }
    default: { }
  }
}
