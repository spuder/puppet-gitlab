class { 'gitlab' :

# https://github.com/spuder/puppet-gitlab/issues/94

  puppet_manage_config   => true,  # If true, puppet will manage /etc/gitlab/gitlab.rb
  puppet_manage_backups  => true,  # If true, puppet will manage cron job to backup at 2am
  puppet_manage_packages => true,  # If true, Puppet will manage openssl and postfix packages

  gitlab_branch           => '7.4.3',
  gitlab_release          => 'basic',
  external_url            => 'http://192.168.33.10',
  gitlab_download_link    => 'https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.4.3_omnibus.1-1.el6.x86_64.rpm',

  # SSL highly recommended
   redirect_http_to_https  => false,
}
