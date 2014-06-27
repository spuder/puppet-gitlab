class gitlab::install inherits ::gitlab {
  
  # Download links change depending on the OS
  # Set variables to make it easy to define $gitlab_url 
  
  case $osfamily {
    'Debian': {
      $omnibus_release = "-omnibus-1_amd64.deb"
      $url_separator   = "_" #some urls are gitlab-7.0.0 others gitlab_7.0.0
      $package_manager = 'dpkg'
    }
    'RedHat': {
      $omnibus_release = "_omnibus-1.el6.x86_64.rpm"
      $url_separator   = "-" #some urls are gitlab-7.0.0 others gitlab_7.0.0
      $package_manager = 'rpm'
    }
    default: {fail("Only RedHat and Debain OS's are supported, you have: ${operatingsystem} ${operatingsystemrelease} ")}
  }
  
  # Check if user is running basic or enterprise, download the appropriate package
  case $gitlab_release {
    'basic': {
      $download_prefix = 'https://downloads-packages.s3.amazonaws.com'
    }
    'enterprise': {
      # Gitlab doesn't share what the url is for the enterprise downloads
      # If you have purchased enterprise and can test this, please let me know!
      warning("The download for gitlab enterprise is untested, download may fail, please contact owenspencer@gmail.com")
      $download_prefix = 'https://downloads-packages.s3.amazonaws.com'
    }
    default : {
      fail( "\$gitlab_release is neither 'basic' or 'enterprise', either you have a typo or you have found a bug, please report to issues'")
    }
  }
  
  # Sets the download url. Examples for gitlab basic
  # https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
  # https://downloads-packages.s3.amazonaws.com/debian-7.5/gitlab_7.0.0-omnibus-1_amd64.deb
  # https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.0.0-omnibus-1_amd64.deb
  # https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb
  $download_location = '/var/tmp'
  $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}${omnibus_release}" #eg. gitlab_7.0.0-omnibus-1_amd64.deb
  $gitlab_url = "${download_prefix}/${::operatingsystem_lowercase}-${operatingsystemrelease}/${omnibus_filename}"

  notice("Downloading from ${gitlab_url}")

  package {'wget':
    ensure => present,
  }
  
  # Use wget to download gitlab, assumes no authentication
  exec { 'download gitlab':
    command => "/usr/bin/wget ${gitlab_url} -O ${download_location}/${omnibus_filename}",
    creates => "${download_location}/${omnibus_filename}",
    timeout => 1800,
    require => Package['wget'],
  }
   package { 'gitlab':
     ensure   => installed,
     source   => "${download_location}/${omnibus_filename}",
     provider => "${package_manager}",
     require  => Exec['download gitlab'],
   }

}