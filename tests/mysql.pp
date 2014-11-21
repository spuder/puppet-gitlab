class { 'gitlab' :
  gitlab_branch                     => '7.5.0',
  gitlab_release                    => 'enterprise',
  gitlab_download_link              => 'https://download.gitlab.com/example.rpm',

  # Disable postgresql and enable mysql
  postgresql_enable                 => false,
  mysql_enable                      => true,
  mysql_host                        => '127.0.0.1',
  mysql_port                        => '3306',
  mysql_username                    => 'gitlab',
  mysql_password                    => 'super_secret',
}
