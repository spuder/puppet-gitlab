# init -> packages -> user -> setup -> install -> config -> service
class gitlab::install inherits gitlab {
  # Execute all commands as the git user
  Exec {
    user => "${gitlab::git_user}",
    path => '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin:/bin',
  }

  # Install gitlab-shell
  exec { 'install gitlab-shell':
    command => "ruby ${gitlab::git_home}/gitlab-shell/bin/install",
    creates => "${gitlab::git_home}/repositories",
  }

  # Install gitlab
  exec { 'install gitlab':
    cwd     => "${gitlab::git_home}/gitlab",
    command => 'bundle install --deployment --without development test postgres aws',
    unless  => "/usr/bin/test -f ${gitlab::git_home}/.gitlab_setup_done",
    timeout => 600,
    before  => [
           File["${gitlab::git_home}/.gitlab_setup_done"],
           Exec['setup gitlab database'],
               ],
  }

  # Setup gitlab database
  exec { 'setup gitlab database':
    cwd     => "${gitlab::git_home}/gitlab",
    command => '/usr/bin/yes yes | bundle exec rake gitlab:setup RAILS_ENV=production',
    unless  => "/usr/bin/test -f ${gitlab::git_home}/.gitlab_database_done",
    timeout => 600,
    before  => File["${gitlab::git_home}/.gitlab_database_done"],
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
