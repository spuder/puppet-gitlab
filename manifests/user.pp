#init -> packages -> user -> setup -> install -> config -> service
class gitlab::user inherits gitlab {
  
  user { "${gitlab::params::git_user}": 
    name        => "${gitlab::params::git_user}",
    ensure      => present, 
    shell       => '/bin/false',                  #Disable logging in
    password   => '*',
    home        => "${gitlab::params::git_home}",
    system      => true,                          #Makes sure user has uid less than 500 (or 1000)
    managehome  => true,
    comment     => "${gitlab::params::git_comment}", #Same as --gecos
  }
  
}#end user.pp