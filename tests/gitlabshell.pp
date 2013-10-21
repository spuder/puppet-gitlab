#Tests the creation of the installation of the gitlab shell

include gitlab
#https://github.com/gitlabhq/gitlab-shell.git


  Exec {
    user    => "${gitlab::git_user}",
    cwd     => "${gitlab::git_home}",
    path  => '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin:/bin',
  }
  
  #Download gitlab-shell (replaces git-o-lite)
  exec { 'download gitlab-shell':
    command   => "git clone ${gitlab::gitlabshell_sources} ${gitlab::git_home}/gitlab-shell",
    creates   => "${gitlab::git_home}/gitlab-shell",

  }
  
  #Copy the gitlab-shell config
  file { "/home/git/gitlab-shell/config.yml":
    ensure    => file,
    content   => template('gitlab/gitlab-shell.config.yml.erb'),
    require   => [
                  Exec['download gitlab-shell'],
                  ],
  }
  

  
  #Install gitlab-shell
  exec { 'install gitlab-shell':
    command   => "ruby ${gitlab::git_home}/gitlab-shell/bin/install",
    creates   => "${gitlab::gitlab_repodir}/gitlab-shell/repositories",
    require    => [
                  Exec['download gitlab-shell'],
                  File['/home/git/gitlab-shell/config.yml'],
                  ],
                 
  }