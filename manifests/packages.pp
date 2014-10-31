# == Class: gitlab::packages
#
# Installs openssh and postfix services
#
# === Parameters
#
# === Examples
#
# DO NOT CALL THIS CLASS DIRECTLY, it is included automatically by init.pp
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab::packages inherits ::gitlab {

  # The install documentation recommends different mail apps for different releases
  # https://about.gitlab.com/downloads/
  case $::operatingsystem {
    'CentOS': {
      $mail_application = 'postfix'
      $ssh_service_name = 'sshd'
      
      case $::operatingsystemrelease {
        /^6/: {
            exec {"chkconfig ${mail_application} on":
              path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
              command => "chkconfig ${mail_application} on",
              unless  => "chkconfig --list ${mail_application} | grep -q 'on' 2>/dev/null ",
              require => [ Package[$mail_application] ],
            }
        }
        /^7/: {
            exec {'systemctl enable sshd':
              path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
              command => "systemctl enable ${ssh_service_name}",
              unless  => "systemctl is-enabled ${ssh_service_name}",
              require => [ Package['openssh-server'] ],
            }
            exec {"systemctl start ${mail_application}":
              path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
              command => "systemctl enable ${mail_application}",
              unless  => "systemctl is-enabled ${mail_application}",
              require => [ Package['openssh-server'] ],
            }
        }
        default: {
          fail("Only CentOS 6 and 7 are presently supported, found: ${::osfamily}-${::operatingsystem}-${::operatingsystemrelease} ")
        }
      }
    }
    'Ubuntu': {
      $mail_application = 'postfix'
      $ssh_service_name = 'ssh'

    }
    'Debian': {
      $mail_application = 'postfix'
      $ssh_service_name = 'ssh'

    }
    default: {
      fail("Only CentOS, Ubuntu and Debian presently supported, found \'${::osfamily}\':\'${::operatingsystem}\'-\'${::operatingsystemrelease}\' ")
    }
  }

  package { 'openssh-server':
    ensure => latest,
  }
  package { $mail_application:
    ensure => latest,
  }
  service { $mail_application:
    ensure  => running,
    require => Package['openssh-server'],
  }
  service { $ssh_service_name:
    ensure  => running,
    require => Package['openssh-server'],
  }

}
