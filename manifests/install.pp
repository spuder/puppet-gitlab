# init -> packages -> user -> setup -> install -> config -> service
class gitlab::install inherits gitlab {
  # Execute all commands as the git user
  Exec {
    user => "${gitlab::params::git_user}",
    path => '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin:/bin',
  }

  # Install gitlab-shell
  exec { 'install gitlab-shell':
    command => "ruby ${gitlab::params::git_home}/gitlab-shell/bin/install",
    creates => "${gitlab::params::gitlab_repodir}/gitlab-shell/repositories",
  }

  # Install gitlab
  exec { 'install gitlab':
    cwd     => "${gitlab::params::git_home}/gitlab",
    command => 'bundle install --deployment --without development test postgres aws',
    unless  => "/usr/bin/test -f ${gitlab::params::git_home}/.gitlab_setup_done",
    before  => [
              File["${gitlab::params::git_home}/.gitlab_setup_done"], 
              Exec['setup gitlab database'],
              ],
  }

  # Setup gitlab database
  exec { 'setup gitlab database':
    cwd     => "${gitlab::params::git_home}/gitlab",
    command => '/usr/bin/yes yes | bundle exec rake gitlab:setup RAILS_ENV=production',
    unless  => "/usr/bin/test -f ${gitlab::params::git_home}/.gitlab_database_done",
    before  => File["${gitlab::params::git_home}/.gitlab_database_done"],
  }

  # Trap door to only allow database setup once
  file { "${gitlab::params::git_home}/.gitlab_database_done":
    ensure  => present,
    content => "database setup for gitlab ${gitlab::params::gitlab_branch} completed",
    owner   => "${gitlab::params::git_user}",
    group   => 'git',
    mode    => '0644',
  }

  # Trap door to only allow gitlab install once
  file { "${gitlab::params::git_home}/.gitlab_setup_done":
    ensure  => present,
    content => "gitlab setup for gitlab ${gitlab::params::gitlab_branch} completed",
    owner   => "${gitlab::params::git_user}",
    group   => 'git',
    mode    => '0644'
  }

}
# end install.pp
