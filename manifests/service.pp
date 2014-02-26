# init -> packages -> user -> setup -> install -> config -> service
class gitlab::service inherits gitlab {

  # init script
  file { '/etc/init.d/gitlab':
    ensure    =>  file,
    content   =>  template("gitlab/init.${gitlab::gitlab_branch}.erb"),
    owner     =>  root,
    group     =>  root,
    mode      =>  '0755',
  }

  # gitlab service
  service { 'gitlab' :
    ensure      =>  running,
    enable      =>  true,
    hasrestart  =>  true,
    # hasstatus  =>  true, #https://ask.puppetlabs.com/question/3382/starting-service-fails/
    status      =>  '/etc/init.d/gitlab status | /bin/grep -q "up and running"',
    subscribe   =>  File['/etc/init.d/gitlab'],
  }

  # 6-4 added a precompile rake command
  exec {'bundle exec rake assets:precompile RAILS_ENV=production':
    cwd     =>  "${gitlab::git_home}/gitlab",
    user    =>  "${gitlab::git_user}",
    path    =>  '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin:/bin',
    unless  =>  "/usr/bin/test -f ${gitlab::git_home}/.precompile_done",
    before  =>  File["${gitlab::git_home}/.precompile_done"],
  }

  # Trap door to only allow precompile once
  file{"${gitlab::git_home}/.precompile_done":
    ensure  =>  present,
    content =>  "precompile for gitlab ${gitlab::gitlab_branch} completed",
    owner   =>  "${gitlab::git_user}",
    group   =>  'git',
    mode    =>  '0644',
  }

  service { 'nginx' :
    ensure      =>  running,
    enable      =>  true,
    hasrestart  =>  true,
    hasstatus   =>  true,
    require     =>  Service ['gitlab'],
  }

}
