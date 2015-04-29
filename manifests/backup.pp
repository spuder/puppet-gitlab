# == Class: gitlab::backup
#
#  Optional Class, creates cron job to backup gitlab. The time can be
#  specified with a set of variables. Set $gitlab_manage_backups to
#  'false' in class declaration if you wish to manually manage backups.
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
class gitlab::backup inherits ::gitlab (
  $backup_hour     = 2,
  $backup_minute   = 0,
  $backup_month    = undef,
  $backup_day      = undef,
  $backup_monthday = undef,
  $backup_weekday  = undef,
) {

  # Execute rake backup
  cron { 'gitlab-backup':
    command  => 'CRON=1 /opt/gitlab/bin/gitlab-rake gitlab:backup:create',
    user     => root,
    hour     => $backup_hour,
    minute   => $backup_minute,
    month    => $backup_month,
    day      => $backup_day,
    monthday => $backup_monthday,
    weekday  => $backup_weekday,
  }

}
