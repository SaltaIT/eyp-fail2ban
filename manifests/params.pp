class fail2ban::params {


  $service_name='fail2ban'

  $filterd='/etc/fail2ban/filter.d'
  $actiond='/etc/fail2ban/action.d'

  case $::osfamily
  {
    'redhat':
    {
      $use_epel=true
      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
          $package_name='fail2ban'
        }
        /^7.*$/:
        {
          $package_name=[ 'fail2ban', 'fail2ban-systemd' ]
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $use_epel=false
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
            }
            /^16.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
