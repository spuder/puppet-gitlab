class gitlab::config inherits ::gitlab {

$gitlab_config_dir = '/etc/gitlab'

  file { "${gitlab_config_dir}/gitlab-puppet.rb":
    content => template('gitlab/gitlab-puppet.rb.erb'),
  }

}