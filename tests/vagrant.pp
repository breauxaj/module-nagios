node default {
  include ::nagios

  case $::osfamily {
    'Debian': {

    }
    'RedHat': {
      case $::operatingsystem {
        'Amazon': {
          Package { allow_virtual => false }
          
          nagios::cgi { 'default':
            content => 'main_config_file=/etc/nagios/nagios.cfg
physical_html_path=/usr/share/nagios/html
url_html_path=/nagios
show_context_help=0
use_pending_states=1
use_authentication=1
use_ssl_authentication=0
authorized_for_system_information=nagiosadmin
authorized_for_configuration_information=nagiosadmin
authorized_for_system_commands=nagiosadmin
authorized_for_all_services=nagiosadmin
authorized_for_all_hosts=nagiosadmin
authorized_for_all_service_commands=nagiosadmin
authorized_for_all_host_commands=nagiosadmin
default_statusmap_layout=5
default_statuswrl_layout=4
ping_syntax=/bin/ping -n -U -c 5 $HOSTADDRESS$
refresh_rate=90
result_limit=100
escape_html_tags=1
action_url_target=_blank
notes_url_target=_blank
lock_author_names=1'
          }

        }
        default: {

        }
      }
    }
    default: { }
  }
}
