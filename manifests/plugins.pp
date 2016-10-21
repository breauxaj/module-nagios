# Class: nagios::plugins
#
# This class installs Nagios Plugins
#
# Parameters:
#
# Actions:
#   - Installs the nagios plugins
#
# Requires:
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'nagios::plugins': }
#
class nagios::plugins (
  $ensure = $::nagios::params::nagios_package_ensure
) inherits ::nagios::params {
  case $::osfamily {
    'RedHat': {
      package { $::nagios::params::nagios_plugins_packages:
        ensure  => $ensure,
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
