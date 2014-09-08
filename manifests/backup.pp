# == Class: gitlab::backup
#
#  Optional Class, creates cron job to backup gitlab at 2 am every night.
#  Set $gitlab_manage_backups to 'false' in class declaration if you wish to 
#  manually manage backups
#
# === Parameters
#
# === Examples
#
# DO NOT CALL THIS CLASS DIRECTLY, instead set puppet_manage_backups
#  class { 'gitlab' : 
#   gitlab_branch          => '7.0.0',
#   external_url           => 'http://foo.bar',
#   puppet_manage_backups  => false,
#  }
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab::backup inherits ::gitlab {

  # Execute rake backup every night at 2 am
  cron { 'gitlab-backup':
    command => '/opt/gitlab/bin/gitlab-rake gitlab:backup:create',
    user    => root,
    hour    => 2,
    minute  => 0,
  }

}
