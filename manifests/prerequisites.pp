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
      fail("Only Centos, Ubuntu and Debian OS's presently supported, found ${::operatingsystem}")
    }
  }

  package { 'openssh-server':
    ensure => latest,
  }
  package { "${mail_application}":
    ensure => latest,
  }


}