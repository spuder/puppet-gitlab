# == Class: gitlab::prerequisites
#
# Installs openssh and postfix services
#
# === Parameters

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
class gitlab::prerequisites inherits ::gitlab {

  # The install documentation recomends different mail apps for different releases
  # https://about.gitlab.com/downloads/
  case $::operatingsystem {
    'CentOS': {
      $mail_application = 'postfix'
    }
    'Ubuntu': {
      $mail_application = 'postfix'
    }
    'Debian': {
      $mail_application = 'exim4-daemon-light'
    }
    default: {
      fail("Only Centos, Ubuntu and Debian presently supported, found \'${::osfamily}\':\'${::operatingsystem}\'-\'${::operatingsystemrelease}\' ")
    }
  }

  package { 'openssh-server':
    ensure => latest,
  }
  package { "${mail_application}":
    ensure => latest,
  }


}