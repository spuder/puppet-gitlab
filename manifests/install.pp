class gitlab::install inherits ::gitlab {
  
  # Download links change depending on the OS
  # Set variables to make it easy to define $gitlab_url 
  
  case $osfamily {
    'Debian': {
      $omnibus_release = "-omnibus-1_amd64.deb"
      $url_separator = "_"
    }
    'RedHat': {
      $omnibus_release = "_omnibus-1.el6x86_64.rpm"
      $url_separator = "-" 
    }
    default: {fail("Only RedHat and Debain OS's are supported, you have: ${operatingsystem} ")}
  }

  # Sets the download url. Examples
  # https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
  # https://downloads-packages.s3.amazonaws.com/debian-7.5/gitlab_7.0.0-omnibus-1_amd64.deb
  # https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.0.0-omnibus-1_amd64.deb
  # https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb
  $gitlab_url = "https://downloads-packages.s3.amazonaws.com/ubuntu-${operatingsystemrelease}/gitlab${url_separator}${::gitlab::gitlab_branch}${omnibus_release}"
  # $gitlab_url = "https://downloads-packages.s3.amazonaws.com/${operatingsystem}-${operatingsystemrelease}/gitlab${url_separator}${::gitlab::gitlab_branch}${omnibus_release}"

  notice("Downloading from ${gitlab_url}")

  package {'wget':
    ensure => present,
  }
  exec { "download gitlab":
    command => "/usr/bin/wget --progress=dot -nv ${gitlab_url} -O /tmp/gitlab${url_separator}${::gitlab::gitlab_branch}${omnibus_release} 2>&1",
    creates => "/var/tmp/gitlab${url_separator}${::gitlab::gitlab_branch}${omnibus_release}",
    require => Package['wget'],
  }
  
  
  
}