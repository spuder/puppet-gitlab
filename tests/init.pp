class { 'gitlab' :

  puppet_manage_config   => true,  # If true, puppet will manage /etc/gitlab/gitlab.rb
  puppet_manage_backups  => true,  # If true, puppet will manage cron job to backup at 2am
  puppet_manage_packages => true,  # If true, Puppet will manage openssl and postfix packages

  gitlab_branch           => '7.4.2',
  gitlab_release          => 'basic',
  external_url            => 'http://192.168.33.10',
  backup_hour             => 2,
  backup_minute           => 0,
  backup_month            => 1,
  backup_monthday         => 1,
  backup_weekday          => 1,

 

  # SSL highly recommended
   redirect_http_to_https  => false,
}
