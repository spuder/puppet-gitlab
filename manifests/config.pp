class gitlab::config inherits ::gitlab {

  file {'/tmp/herp':
    content => template('gitlab/gitlab-puppet.rb.erb'),
  }

}