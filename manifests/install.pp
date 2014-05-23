# init -> packages -> user -> setup -> install -> config -> service
class gitlab::install inherits gitlab {
  # Execute all commands as the git user
  Exec {
    user => "${gitlab::git_user}",
    path => '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin:/bin',
  }

  # Install gitlab
  exec { 'install gitlab':
    cwd     => "${gitlab::git_home}/gitlab",
    command => "bundle install -j${::processorcount} --deployment --without development test postgres aws",
    unless  => "/usr/bin/test -f ${gitlab::git_home}/.gitlab_setup_done",
    timeout => 600,
    before  => [
           File["${gitlab::git_home}/.gitlab_setup_done"],
           Exec['setup gitlab database'],
           Exec['install gitlab-shell'],
               ],
  }
  
  # In gitlab 6-9 the installation of gitlab-shell was converted into a rake task
  if "${gitlab::gitlab_branch}" <= 6-8-stable {
    
    # Install gitlab-shell
    exec { 'install gitlab-shell':
      command => "ruby ${gitlab::git_home}/gitlab-shell/bin/install",
      creates => "${gitlab::git_home}/repositories",
      timeout => 600,
    }
    
  }
  else {
    
    exec { 'install gitlab-shell':
      cwd     => "${gitlab::git_home}/gitlab",
      command => "bundle exec rake gitlab:shell:install[${gitlab::gitlabshell_branch}] REDIS_URL=redis://localhost:6379 RAILS_ENV=production",
      timeout => 300,
      user    => 'git',
    }
    
  }
  
  # Setup gitlab database
  exec { 'setup gitlab database':
    cwd     => "${gitlab::git_home}/gitlab",
    command => '/usr/bin/yes yes | bundle exec rake gitlab:setup RAILS_ENV=production',
    unless  => "/usr/bin/test -f ${gitlab::git_home}/.gitlab_database_done",
    timeout => 600,
    before  => File["${gitlab::git_home}/.gitlab_database_done"],
    require => Exec['install gitlab-shell'],
  }

  # Trap door to only allow database setup once
  file { "${gitlab::git_home}/.gitlab_database_done":
    ensure  => present,
    content => "database setup for gitlab ${gitlab::gitlab_branch} completed",
    owner   => "${gitlab::git_user}",
    group   => 'git',
    mode    => '0644',
  }

  # Trap door to only allow gitlab install once
  file { "${gitlab::git_home}/.gitlab_setup_done":
    ensure  => present,
    content => "gitlab setup for gitlab ${gitlab::gitlab_branch} completed",
    owner   => "${gitlab::git_user}",
    group   => 'git',
    mode    => '0644'
  }


  
  
}
# end install.pp
