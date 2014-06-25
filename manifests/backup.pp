class gitlab::backup inherits ::gitlab {

  # Execute rake backup every night at 2 am
  cron { 'gitlab-backup':
    command => "/opt/gitlab/bin/gitlab-rake gitlab:backup:create",
    user    => root,
    hour    => 2,
    minute  => 0,
  }
}