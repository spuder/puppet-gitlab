# init -> packages -> user -> setup -> install -> config -> service
class gitlab::user inherits gitlab {


  # Sets the user to the following useradd --disabled-login --gecos 'Gitlab' git
  # Note, this is only reliable in setting up new user, not updating existing
  user { "${gitlab::git_user}":
    ensure      =>  present,
    name        =>  "${gitlab::git_user}",
    shell       =>  '/bin/bash',
    password    =>  '!', # same as --disabled-login,
    home        =>  "${gitlab::git_home}",
    # system     =>  true, #Makes sure user has uid less than 500 (or 1000)
    managehome  =>  true,
    comment     =>  "${gitlab::git_comment}", # Same as --gecos
  }

}# end user.pp
