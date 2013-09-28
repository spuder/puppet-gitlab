 
include mysql
include gitlab #only needed if you want to call gitlab::params


class { 'mysql::server':
  config_hash => { 'root_password' => 'badpassword' }
}

mysql::db { "$gitlab::params::gitlab_dbname" :
  ensure    => present,
  user      => "$gitlab::params::gitlab_dbuser",
  password  => "$gitlab::params::gitlab_dbpwd",
  host      => "$gitlab::params::gitlab_dbhost",
  grant     => ['all'],
  #TODO: change from all, to just the permissions specififed in the install doc
}

