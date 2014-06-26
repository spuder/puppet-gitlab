class gitlab::config inherits ::gitlab {

  $gitlab_config_dir = '/etc/gitlab'

  file { "${gitlab_config_dir}/gitlab.rb":
    content => template('gitlab/gitlab-puppet.rb.erb'),
    backup  => true,
  }
  exec { "/usr/bin/gitlab-ctl reconfigure":
    refreshonly => true,
    subscribe   => File["${gitlab_config_dir}/gitlab.rb"],
  }

}