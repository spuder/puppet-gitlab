#init -> packages -> user -> setup -> install -> config -> service
class gitlab::config inherits params {
  
  File {
    owner   => "${gitlab::params::git_user}",
    group   => 'git',    
  }
  
  
  #Create log directory
  file { "${gitlab::params::git_home}/gitlab/log":
    ensure  => directory, 
    mode    => '0755',
  }
  
  #Create tmp directory
  file { "${gitlab::params::git_home}/gitlab/tmp":
    ensure  => directory, 
    mode    => '0755',
  }

  #Create pids directory
  file { "${gitlab::params::git_home}/gitlab/tmp/pids" :
    ensure  => directory,
    mode    =>  '0755',
  }
  
  #Create socket directory
  file { "${gitlab::params::git_home}/gitlab/tmp/sockets" :
    ensure  => directory,
    mode    => '0755',
  }
  
  #Create satellites directory
  file { "${gitlab::params::git_home}/gitlab-satellites":
    ensure    => directory,
    mode      => '0755',
  }  
  
  #Create public/uploads directory otherwise backups will fail
  file { "${gitlab::params::git_home}/gitlab/public/uploads":
    ensure    => directory,
    mode      => '0755',
  }
  
  #Create nginx sites-available directory
  file { '/etc/nginx/sites-available':
    ensure    => directory, 
    owner     => 'root',
    group     => 'root',
  }
  
  #Create nginx sites-enabled directory
  file { '/etc/nginx/sites-enabled':
    ensure    => directory, 
    owner     => 'root',
    group     => 'root',
  }
  
  #Copy nginx config to sites-available
  file { '/etc/nginx/sites-available/gitlab':
    ensure    => file,
    content   => template('gitlab/gitlab.nginx-gitlab.conf.erb'),
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
  }
  
  #Create symbolic link
  file  { '/etc/nginx/sites-enabled/gitlab':
    ensure    => link,
    target    => '/etc/nginx/sites-available/gitlab',
    owner     => 'root',
    group     => 'root',
  }
  
  
#  file { "${gitlab::params::git_home}/.gitconfig":
#    ensure    => file,
#    content   => template('gitlab/gitlab-.gitconfig.erb'),
#    mode      => '0644',
#    owner     => "${gitlab::git_user}",
#  }
  
#  Setup global git user
  exec { 'git config --global user.name':
    path    => '/usr/bin:/usr/local/bin',
    environment => "HOME=/home/git",   #http://projects.puppetlabs.com/issues/5224
    #environment => '/root',
    #user    => "${gitlab::params::git_user}",
    command => "git config --global user.name ${gitlab::git_comment}",
    #TODO: Force this to not just run once
    
  }
  
  #Setup global git email 
  exec { 'git config --global user.email':
    path        => '/usr/bin:/usr/local/bin',
    environment => "HOME=/home/git",  #http://projects.puppetlabs.com/issues/5224
    #environment => '/root',
    #user        => "${gitlab::git_user}",
    command     => "git config --global user.email ${gitlab::git_email}",
    #TODO: Force this to not just run once   
    #TODO: Figure out why email is git@ac and not the value specified in the git_email variable
    
  }
  
  #Setup global core.autocrlf input
  exec { 'git config --global core.autocrlf input':
    path        => '/usr/bin:/usr/local/bin',
    environment => "HOME=/home/git",  #http://projects.puppetlabs.com/issues/5224
    #environment => '/root',
    #user        => "${gitlab::git_user}",
    command     => "git config --global core.autocrlf input",
    #TODO: Force this to not just run once       
  }
  
  #Set owner and permissions of /home/git/.gitconfig
  file { "${gitlab::params::git_home}/.gitconfig":
    ensure  => file, 
    owner   => "${gitlab::git_user}",
    group   => 'git',
    mode    => '0644',
  }
 
  #Overwrite gitlab icons with custom icons
	case "${gitlab::custom_thumbnail_icon}" {
		  'true':
	    {
	        warning("gitlab:custom_thumbnail_icon is true, altering gitlab icons")
	      
	        file{"${gitlab::git_home}/gitlab/app/assets/images/logo-white.png":
	            source => "puppet:///modules/gitlab/logo-white.png.erb",
	            owner   => "${gitlab::git_user}",
	            group   => 'git',
	            mode    => '0644',
	        }
	        file{"${gitlab::git_home}/gitlab/app/assets/images/logo-black.png.erb":
	            source => "puppet:///modules/gitlab/logo-black.png.erb",
	            owner   => "${gitlab::git_user}",
	            group   => 'git',
	            mode    => '0644',
	        }
	    }#end false
		
		  'false': 
		  {
		      warning("gitlab:custom_thumbnail_icon is false, leaving stock icons")
		  }#end true
		  
		  default: 
		  {
		     warning("gitlab:custom_thumbnail_icon is not defined")
		  }
	}#end case


}#end config.pp
