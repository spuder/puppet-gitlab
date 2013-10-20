#init -> packages -> user -> setup -> install -> config -> service
class gitlab::user inherits gitlab {

  user { "${gitlab::git_user}":
    ensure      => present,
    name        => "${gitlab::git_user}",
    #shell       => '/bin/false',      #https://github.com/gitlabhq/gitlabhq/pull/5218
    shell       => '/bin/bash',
    password    => '*',
    home        => "${gitlab::git_home}",
    system      => true,                   #Makes sure user has uid less than 500 (or 1000)
    managehome  => true,
    comment     => "${gitlab::git_comment}", #Same as --gecos
  }

}#end user.pp
