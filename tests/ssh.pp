

    class { 'mysql::server':
      root_password   => 'foo', 
    }

  
    class { 'gitlab' : 
      git_email              => 'git@foo.com',
      gitlab_branch          => '6-5-stable',
      gitlabshell_branch     => 'v1.8.0',
      git_ssh_port          => '666',
      
   }
      
      
  
  
