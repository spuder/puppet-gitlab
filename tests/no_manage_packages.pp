class { 'gitlab' :

  puppet_manage_config   => false,  # If true, puppet will manage /etc/gitlab/gitlab.rb
  puppet_manage_backups  => false,  # If true, puppet will manage cron job to backup at 2am
  puppet_manage_packages => false,  # If true, Puppet will manage openssl and postfix packages

  gitlab_branch           => '7.1.0',
  gitlab_release          => 'basic',
  external_url            => 'http://192.168.33.10',
  
  # SSL highly recomended
  redirect_http_to_https  => true,
}
