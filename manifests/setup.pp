#init -> packages -> user -> setup -> install -> config -> service  
 class gitlab::setup inherits gitlab {
   
  #Install bundler gem
  package { 'bundler':
    ensure    => installed,
    provider  => gem,
  }
  
  package { 'mysql2' :
    ensure    => '0.3.11',
    provider  => gem,
  }
  
  #Install charlock_holmes 
  package { 'charlock_holmes':
    ensure    => '0.6.9.4',
    provider  => 'gem',
    require   => [
                  Package['bundler'],
                  Package['mysql2'],
                  ],
  }
  
  notify { "Installing charlock holmes with ruby version ${::rubyversion}" : 
  }
  
  #Execute all commands as the git user in the git home directory
  Exec {
    user    => "${gitlab::params::git_user}",
    cwd     => "${gitlab::params::git_home}",
    path    => '/usr/bin',
  }
  
  #Download gitlab-shell (replaces git-o-lite)
  exec { 'download gitlab-shell':
    command   => "git clone ${gitlab::params::gitlabshell_sources} ${gitlab::params::git_home}/gitlab-shell",
    creates   => "${gitlab::params::git_home}/gitlab-shell",
  }
  
  #Download gitlab source
  exec { 'download gitlab':
    command => "git clone -b ${gitlab::params::gitlab_branch} ${gitlab::params::gitlab_sources} ${gitlab::params::git_home}/gitlab",
    creates   => "${gitlab::params::git_home}/gitlab",
  }
  
  
  #Copy the gitlab-shell config
  file { "${gitlab::params::git_home}/gitlab-shell/config.yml":
    ensure    => file,
    content   => template('gitlab/gitlab-shell.config.yml.erb'),
    owner     => "${gitlab::params::git_user}",
    group     => 'git', #TODO: Is git the best way to do this? 
    require   => [
                  Exec['download gitlab-shell'],
                  Exec['download gitlab'],
                  ]
  }
  
  
  #Copy the gitlab config
  file { "${gitlab::params::git_home}/gitlab/config/gitlab.yml":
    ensure    => file,
    content   => template('gitlab/gitlab.yml.6.0.erb'),
    owner     => "${gitlab::params::git_user}",
    group     => 'git', #TODO: Is git the best way to do this? 
    require   => [
                  Exec['download gitlab-shell'],
                  Exec['download gitlab'],
                  ]
  }
  
  #Copy the Unicorn config
  file { "${gitlab::params::git_home}/gitlab/config/unicorn.rb":
    ensure    => file,
    content   => template('gitlab/gitlab.unicorn.rb.erb'),
    owner     => "${gitlab::params::git_user}",
    group     => 'git',
    require   => [
                  Exec['download gitlab-shell'],
                  Exec['download gitlab'],
                  ]
  }
  
  #Copy the database config
  file { "${gitlab::params::git_home}/gitlab/config/database.yml":
    ensure    => file,
    content   => template('gitlab/gitlab.database.yml.erb'),
    owner     => "${gitlab::params::git_user}",
    group     => 'git',
    mode      => '0640',
    require   => [
                  Exec['download gitlab-shell'],
                  Exec['download gitlab'],
                  ]
  }
  
  
}#end setup.pp

