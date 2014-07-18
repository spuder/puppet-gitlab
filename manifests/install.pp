# == Class: gitlab::install
#
# This class downloads and installs gitlab using the apprpriate package manager
# The download location can be specified by modifying $gitlab::gitlab_download_link
#
# === Parameters
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*operatingsystem_lowercase*]
#   A custom fact to get the lowercase os distribution (eg. ubuntu, centos)
#   Used to generate the download url.
#   See lib/facter/operatingsystem_lowercase.rb
#
# === Examples
#
# DO NOT CALL THIS CLASS DIRECTLY, SEE tests/init.pp FOR EXAMPLE
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab::install inherits ::gitlab {

  # Sets the download url. Examples for gitlab basic
  # https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
  # https://downloads-packages.s3.amazonaws.com/debian-7.5/gitlab_7.0.0-omnibus-1_amd64.deb
  # https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/gitlab_7.0.0-omnibus-1_amd64.deb
  # https://downloads-packages.s3.amazonaws.com/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb
  $download_location = '/var/tmp'
  $download_prefix   = 'https://downloads-packages.s3.amazonaws.com' #Default download prefix for basic edition

  # Download links change depending on the OS
  # Filename changes depending if basic or enterprise
  # Set variables to make it easy to define $gitlab_url 
  case $::osfamily {
    'Debian': {
      $omnibus_release = 'omnibus-1_amd64.deb'
      $url_separator   = '_' #some urls are gitlab-7.0.0 others gitlab_7.0.0
      $package_manager = 'dpkg'

        case $::gitlab::gitlab_release {
          'basic' : {
            $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}-${omnibus_release}" # eg. gitlab_7.0.0-omnibus-1_amd64.deb
          }
          'enterprise' : {
            $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}-ee.${omnibus_release}" # eg. gitlab_7.0.0-ee.omnibus-1_amd64.deb 
          }
          default : {
            fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: ${::gitlab::gitlab_release}")
          }
        }
    }
    'RedHat': {
      $omnibus_release = 'omnibus-1.el6.x86_64.rpm'
      $url_separator   = '-' #some urls are gitlab-7.0.0 others gitlab_7.0.0
      $package_manager = 'rpm'

        case $::gitlab::gitlab_release {
          'basic' : {
            $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}_${omnibus_release}" # eg. gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
          }
          'enterprise' : {
            $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}_ee.${omnibus_release}" # eg. gitlab-7.0.0_ee.omnibus-1.el6.x86_64.rpm
          }
          default : {
            fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: ${::gitlab::gitlab_release}")
          }
        }
    }
    default: {fail("Only RedHat and Debian os families are supported, Found: \'${::osfamily}\':\'${::operatingsystem}\'-\'${::operatingsystemrelease}\'")}
  }

  # There are 6 combinations of $gitlab_download_link and $gitlab_release, validate them and conditionally set $gitlab_url
  if $::gitlab::gitlab_download_link {
    case $::gitlab::gitlab_release {
      undef : {
        warning("\$gitlab_release is undefined, yet \$gitlab_download_link is set, assuming gitlab basic")
        info("\$Downloading ${::gitlab::gitlab_release} from user specified url")
        $gitlab_url = "${download_prefix}/${::operatingsystem_lowercase}-${::operatingsystemrelease}/${omnibus_filename}"
      }
      'basic' : {
        warning("\$gitlab_release is ${::gitlab::gitlab_release} and \$gitlab_download_link is \'${::gitlab::gitlab_download_link}\', setting a custom url is most likely unneccesary")
        info("\$Downloading ${::gitlab::gitlab_release} from user specified url")
        $gitlab_url = "${::gitlab::gitlab_download_link}"
      }
      'enterprise': {
        info("\$Downloading ${::gitlab::gitlab_release} from user specified url")
        $gitlab_url = "${::gitlab::gitlab_download_link}"
      }
      default : {
        fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: \'${::gitlab::gitlab_release}\'")
      }
    }
  }
  else {
    case $::gitlab::gitlab_release {
      undef, 'basic' : {
        info("\$gitlab_release is \'${::gitlab::gitlab_release}\' and \$gitlab_download_link is \'${::gitlab::gitlab_download_link}\'")
        # e.g. https://foo/bar/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb 
        $gitlab_url = "${download_prefix}/${::operatingsystem_lowercase}-${::operatingsystemrelease}/${omnibus_filename}"
        info("Downloading from default url ${gitlab_url}")
      }
      'enterprise': {
        fail('You must specify $gitlab_download_link when $gitlab_release is set to \'enterprise\'')
      }
      default : {
        fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: \'${::gitlab::gitlab_release}\'")
      }
    }
  }

  package {'wget':
    ensure => present,
  }
  # Use wget to download gitlab
  exec { 'download gitlab':
    command => "/usr/bin/wget ${gitlab_url}",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin',
    cwd     => "${download_location}",
    creates => "${download_location}/${omnibus_filename}",
    timeout => 1800,
    require => Package['wget'],
  }
  # Install gitlab with the appropriate package manager (rpm or dpkg)
  package { 'gitlab':
    ensure   => installed,
    source   => "${download_location}/${omnibus_filename}",
    provider => "${package_manager}",
    require  => Exec['download gitlab'],
  }

}