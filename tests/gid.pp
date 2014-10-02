class { 'gitlab' :

# Don't blindly apply this class. It is only used for 2 purposes:

# 1. For development to verify that all parameters are incorperated into the erb template properly
# 2. As reference to show *how* to implement each parameter


  # Manage Packages
  puppet_manage_config   => true,  # If true, puppet will manage /etc/gitlab/gitlab.rb
  puppet_manage_backups  => true,  # If true, puppet will manage cron job to backup at 2am
  puppet_manage_packages => true,  # If true, Puppet will manage openssl and postfix packages

  # Gitlab server settings
  gitlab_branch           => '7.3.0',
  gitlab_release          => 'basic', # enterprise or basic
  # gitlab_download_link  => '', #'https://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb',

  external_url            => 'http://192.168.33.10',

  git_username       => 'herp',
  git_groupname      => 'derp',
  #git_uid            => 2001, 
  #git_gid            => 2104,
  #gitlab_redis_uid   => 998,
  #gitlab_redis_gid   => 1003,
  #gitlab_psql_uid    => 997,
  #gitlab_psql_gid    => 1004,


}
