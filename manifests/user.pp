#init -> packages -> user -> setup -> install -> config -> service
class gitlab::user inherits gitlab {
  
  user { "${gitlab::git_user}": 
    name        => "${gitlab::git_user}",
    ensure      => present, 
    shell       => '/bin/false',                  #Disable logging in
    password   => '*',
    home        => "${gitlab::git_home}",
    system      => true,                          #Makes sure user has uid less than 500 (or 1000)
    managehome  => true,
    comment     => "${gitlab::git_comment}", #Same as --gecos
  }
  
}#end user.pp