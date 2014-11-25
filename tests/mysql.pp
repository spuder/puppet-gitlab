class { 'gitlab' :
  gitlab_branch                     => '7.5.0',
  gitlab_release                    => 'enterprise',
  gitlab_download_link              => 'https://download.gitlab.com/example.rpm',

  # Disable postgresql and enable mysql
  postgresql_enable                 => false,
  mysql_enable                      => true,
  db_adapter                        => 'mysql2',
  db_host                           => '127.0.0.1',
  db_port                           => '3306',
  db_username                       => 'gitlab',
  db_password                       => 'super_secret',
}
