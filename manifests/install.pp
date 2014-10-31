# == Class: gitlab::install
#
# This class downloads and installs gitlab using the apprpriate package manager
# The download location can be specified by modifying $gitlab::gitlab_download_link
#
# === Parameters
#
# === Variables
#
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
            #Validate user supplied download link and strip url off of package name. e.g. gitlab_7.0.0-omnibus-1_amd64.deb
            if $::gitlab::gitlab_download_link and $::gitlab::gitlab_download_link =~ /\/([^\/]+)$/ {
              validate_re($1, ['.rpm','.deb'],'gitlab_download_link must end in .rpm or .deb')
              $omnibus_filename = $1
              info("gitlab_release is: ${::gitlab::gitlab_release}, user provided a download url: ${::gitlab::gitlab_download_link}, omnibus_filename is: ${omnibus_filename}")
            }
            else {
              # Use default package name
              $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}-${omnibus_release}" # eg. gitlab_7.0.0-omnibus-1_amd64.deb
              info("gitlab_release is: ${::gitlab::gitlab_release}, using default omnibus_filename: ${omnibus_filename}")
            }
          }
          'enterprise' : {
            #Validate user supplied download link and strip url off of package name. e.g. gitlab_7.0.0-omnibus-1_amd64.deb
            if $::gitlab::gitlab_download_link and $::gitlab::gitlab_download_link =~ /\/([^\/]+)$/ {
              validate_re($1, ['.rpm','.deb'],'gitlab_download_link must end in .rpm or .deb')
              $omnibus_filename = $1
              info("gitlab_release is: ${::gitlab::gitlab_release}, user provided a download url: ${::gitlab::gitlab_download_link}, omnibus_filename is: ${omnibus_filename}")
            }
            else {
              # Use default package name
              $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}-ee.${omnibus_release}" # eg. gitlab_7.0.0-ee.omnibus-1_amd64.deb 
              info("gitlab_release is: ${::gitlab::gitlab_release}, using default omnibus_filename: ${omnibus_filename}")
            }
          }
          default : {
            fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: ${::gitlab::gitlab_release}")
          }
        }
    }
    'RedHat': {
      # Get the operatingsystem major release, used to determine rpm name e.g. omnibus-1.el6.x86_64.rpm or omnibus-1.el7.x86_64.rpm
      # unfortunatly $::operatingsystemmajrelease is only availabe in facter >=1.8
      $cent_maj_version = $::operatingsystemrelease ? {
        /^5/ => '5',
        /^6/ => '6',
        /^7/ => '7',
        /^8/ => '8',
        default => undef,
      }
      # Fail if cent maj version is not one of the following numbers
      validate_re($cent_maj_version,['5','6','7','8'],'Can not determine CentOS major version')
      info("RedHat major version is ${cent_maj_version}")

      # The default rpm name if user doesn't specify $gitlab_download_link
      $omnibus_release = "omnibus-1.el${cent_maj_version}.x86_64.rpm"
      $url_separator   = '-' #some urls are gitlab-7.0.0 others gitlab_7.0.0
      $package_manager = 'rpm'

        case $::gitlab::gitlab_release {
          'basic' : {
            #Validate user supplied download link and strip url off of package name. e.g. gitlab_7.0.0-omnibus-1_amd64.deb
            if $::gitlab::gitlab_download_link and $::gitlab::gitlab_download_link =~ /\/([^\/]+)$/ {
              validate_re($1, ['.rpm','.deb'],'gitlab_download_link must end in .rpm or .deb')
              $omnibus_filename = $1
              info("gitlab_release is: ${::gitlab::gitlab_release}, user provided a download url: ${::gitlab::gitlab_download_link}, omnibus_filename is: ${omnibus_filename}")
            }
            else {
              # Use default package name
              $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}_${omnibus_release}" # eg. gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
              info("gitlab_release is: ${::gitlab::gitlab_release}, using default omnibus_filename: ${omnibus_filename}")
            }
          }
          'enterprise' : {
            #Validate user supplied download link and strip url off of package name. e.g. gitlab_7.0.0-omnibus-1_amd64.deb
            if $::gitlab::gitlab_download_link and $::gitlab::gitlab_download_link =~ /\/([^\/]+)$/ {
              validate_re($1, ['.rpm','.deb'],'gitlab_download_link must end in .rpm or .deb')
              $omnibus_filename = $1
              info("gitlab_release is: ${::gitlab::gitlab_release}, user provided a download url: ${::gitlab::gitlab_download_link}, omnibus_filename is: ${omnibus_filename}")
            }
            else {
              # Use default package name
              $omnibus_filename = "gitlab${url_separator}${::gitlab::gitlab_branch}_ee.${omnibus_release}" # eg. gitlab-7.0.0_ee.omnibus-1.el6.x86_64.rpm
              info("gitlab_release is: ${::gitlab::gitlab_release}, using default omnibus_filename: ${omnibus_filename}")
            }
          }
          default : {
            fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: ${::gitlab::gitlab_release}")
          }
        }
    }
    default: {fail("Only RedHat and Debian os families are supported, Found: \'${::osfamily}\':\'${::operatingsystem}\'-\'${::operatingsystemrelease}\'")}
  }

  # There are 6 combinations of $gitlab_download_link and $gitlab_release, validate them and conditionally set $gitlab_url
  # If user specified $gitlab_download_link:
  if $::gitlab::gitlab_download_link {
    case $::gitlab::gitlab_release {
      undef : {
        # User did not set $gitlab_release, assume basic
        warning("\$gitlab_release is undefined, yet \$gitlab_download_link is set, assuming gitlab basic")
        info("\$Downloading ${::gitlab::gitlab_release} from user specified url: ${::gitlab::gitlab_download_link}")
        # $operatingsystem_lowercase = downcase($::operatingsystem)
        $operatingsystem_lowercase=downcase($::operatingsystem)
        $gitlab_url = "${download_prefix}/${operatingsystem_lowercase}-${::operatingsystemrelease}/${omnibus_filename}"
      }
      'basic' : {
        # Basic version, use user supplied url
        info("Downloading ${::gitlab::gitlab_release} from user specified url: ${::gitlab::gitlab_download_link}")
        $gitlab_url = $::gitlab::gitlab_download_link
      }
      'enterprise': {
        # Enterprise verison, use user supplied url. This is the only valid configuration for enterprise users
        info("Downloading ${::gitlab::gitlab_release} from user specified url: ${::gitlab::gitlab_download_link}")
        $gitlab_url = $::gitlab::gitlab_download_link
      }
      default : {
        # $gitlab_release is neither basic nor enterprise, invalid input
        fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: \'${::gitlab::gitlab_release}\'")
      }
    }
  }
  # If user did not specify $gitlab_download_link
  else {
    case $::gitlab::gitlab_release {
      undef, 'basic' : {
        # Basic version, use default derived url. This is the most common configuration
        info("\$gitlab_release is \'${::gitlab::gitlab_release}\' and \$gitlab_download_link is \'${::gitlab::gitlab_download_link}\'")
        # e.g. https://foo/bar/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb 
        $operatingsystem_lowercase = downcase($::operatingsystem)
        $gitlab_url = "${download_prefix}/${operatingsystem_lowercase}-${::operatingsystemrelease}/${omnibus_filename}"
        info("Downloading from default url ${gitlab_url}")
      }
      'enterprise': {
        # Enterprise version requires the url be provided, fail
        fail('You must specify $gitlab_download_link when $gitlab_release is set to \'enterprise\'')
      }
      default : {
        # $gitlab_release is neither basic nor enterprise, invalid input
        fail("\$gitlab_release can only be 'basic', 'enterprise' or undef. Found: \'${::gitlab::gitlab_release}\'")
      }
    }
  }

  validate_string($omnibus_filename)
  validate_string($download_location)
  info("omnibus_filename is \'${omnibus_filename}\'")

  package {'wget':
    ensure  => present,
  }
  # Use wget to download gitlab
  exec { 'download gitlab':
    command => "/usr/bin/wget ${gitlab_url}",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin',
    cwd     => $download_location,
    creates => "${download_location}/${omnibus_filename}",
    timeout => 1800,
    require => Package['wget'],
  }
  # Install gitlab with the appropriate package manager (rpm or dpkg)
  package { 'gitlab':
    ensure   => latest,
    source   => "${download_location}/${omnibus_filename}",
    provider => $package_manager,
    require  => Exec['download gitlab'],
  }

}
