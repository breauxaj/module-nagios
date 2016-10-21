# Class: nagios
#
# This class installs Nagios
#
# Parameters:
#
# Actions:
#   - Installs the nagios package
#
# Requires:
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'nagios': }
#
class nagios (
  $ensure = $::nagios::params::nagios_package_ensure
) inherits ::nagios::params {
  case $::osfamily {
    'RedHat': {
      package { $::nagios::params::nagios_packages:
        ensure => $ensure,
      }

      file { '/etc/nagios/nagios.cfg':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0664',
        content => template('nagios/nagios.erb'),
        require => Package[$::nagios::params::nagios_packages],
        notify  => Service[$::nagios::params::nagios_service]
      }

      $commands = hiera_hash('nagios_command',{})
      create_resources('nagios_command',$commands)

      $contacts = hiera_hash('nagios_contact',{})
      create_resources('nagios_contact',$contacts)

      $contactgroups = hiera_hash('nagios_contactgroup',{})
      create_resources('nagios_contactgroup',$contactgroups)

      $hosts = hiera_hash('nagios_host',{})
      create_resources('nagios_host',$hosts)

      $hostdependencies = hiera_hash('nagios_hostdependency',{})
      create_resources('nagios_hostdependency',$hostdependencies)

      $hostescalations = hiera_hash('nagios_hostescalation',{})
      create_resources('nagios_hostescalation',$hostescalations)

      $hostextinfos = hiera_hash('nagios_hostextinfo',{})
      create_resources('nagios_hostextinfo',$hostextinfos)

      $hostgroups = hiera_hash('nagios_hostgroup',{})
      create_resources('nagios_hostgroup',$hostgroups)

      $services = hiera_hash('nagios_service',{})
      create_resources('nagios_service',$services)

      $servicedependencies = hiera_hash('nagios_servicedependency',{})
      create_resources('nagios_servicedependency',$servicedependencies)

      $serviceescalations = hiera_hash('nagios_serviceescalation',{})
      create_resources('nagios_serviceescalation',$serviceescalations)

      $serviceextinfos = hiera_hash('nagios_serviceextinfo',{})
      create_resources('nagios_serviceextinfo',$serviceextinfos)

      $servicegroups = hiera_hash('nagios_servicegroup',{})
      create_resources('nagios_servicegroup',$servicegroups)

      $timeperiods = hiera_hash('nagios_timeperiod',{})
      create_resources('nagios_timeperiod',$timeperiods)

      service { 'httpd':
        ensure  => running,
        enable  => true,
        require => Package[$::nagios::params::nagios_packages],
      }

      service { $::nagios::params::nagios_service:
        ensure  => running,
        enable  => true,
        require => Package[$::nagios::params::nagios_packages],
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
