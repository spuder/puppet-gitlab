class gitlab::service inherits gitlab {
  
  #init script
  file { '/etc/init.d/gitlab':
    ensure    => file,
    content   => template("gitlab/init.${gitlab::gitlab_branch}.erb"), 
    owner     => root,
    group     => root,
    mode      => '0755',

  }
  
  #gitlab service
  service { 'gitlab' :
    ensure       => running,
    enable       => true,
    hasrestart   => true,
    #hasstatus   => true, #https://ask.puppetlabs.com/question/3382/starting-service-fails/
    status  => '/etc/init.d/gitlab status | /bin/grep -q "up and running"',
    subscribe    => File['/etc/init.d/gitlab'],  
  }

  service { 'nginx' :
    ensure      => running,
    enable      => true,    
    hasrestart  => true,
    hasstatus   => true, 
    require     => Service ['gitlab'],
  }
}
