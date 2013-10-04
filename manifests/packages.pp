#init -> packages -> user -> setup -> install -> config -> service
class gitlab::packages inherits gitlab {

	$system_packages = [
											'libicu-dev',
											'python2.7',
											'python-docutils',
						          'libxml2-dev',
						          'libxslt1-dev',
	                    'python-dev',
	                    'build-essential',
	                    'libmysqlclient-dev',
	                    'redis-server',
	                    'nginx', #TODO, decide if nginx should be installed via apt, or puppet (pupet had some problems)
	                    ]

                          
	package { $system_packages: 
	  ensure => present,
	}


	
	 #Run apt-get update after repo install
  exec { 'apt-get update':
    path => '/usr/bin',
    command => 'apt-get update',
  } #TODO: use puppetlabs-apt always update resource to manage this
  
  
  
	
	## Git v1.7.10 
	#=====================================
	
	include apt

  #Include git ppa (gitlab requires git 1.7.10 or newer which isn't in standard repo)
	apt::ppa { 'ppa:git-core/ppa': 
	  notify => Exec['apt-get update'],
	}
	
	#Install key for repo (otherwise it prints error)
	
	apt::key { 'ppa:git-core/ppa': 
	    key    => 'E1DF1F24',
	}
	
	
	package { 'git-core': 
	  ensure => present, 
	  require => [
	              Apt::Ppa['ppa:git-core/ppa'],
	              Apt::Key['ppa:git-core/ppa'],
	              ],
  }
	
	
	## Ruby v2.0 (from squeeze ppa)
	#=====================================
	
	#Add ruby2.0 packages to sources
	
	#Create /packages folder for ruby repo's
	file { '/packages':
	  ensure   => directory,
    before   => [
             File ['/packages/ruby2-0-repo'],
             File ['/etc/apt/sources.list.d/ruby2.0.list'],
             Exec ['apt-get install ruby2.0'],
             Exec ['apt-get install ruby2.0-dev'],
             Exec ['apt-get install rake'],
             ],
	}
	
	#Place the custom ruby package in /packages/ruby2-0-repo
	file { '/packages/ruby2-0-repo':
	  source   => "puppet:///modules/gitlab/ruby2-repo",
	  mode     => '0755', 
	  recurse  => true,
	  before   => [
	               File ['/etc/apt/sources.list.d/ruby2.0.list'],
	               Exec ['apt-get install ruby2.0'],
	               Exec ['apt-get install ruby2.0-dev'],
	               Exec ['apt-get install rake'],
	               ],  
	}
	
	#Ubuntu 12.04 doesn't come with ruby2.0, install .deb files from a local repo
	file { '/etc/apt/sources.list.d/ruby2.0.list':
	  content => "deb file:///packages/ruby2-0-repo /",
	  mode    => 0644,
	  owner   => 'root',
	  group   => 'root',
	  notify  => Exec['apt-get update'],
	  before  => Exec['apt-get install ruby2.0'],
  } 
  
  #Install ruby2.0
  exec {'apt-get install ruby2.0':
	  path    => '/usr/bin',
	  command => 'sudo apt-get install -y --force-yes ruby2.0',
	  require => Exec['apt-get update'],
  }
  
  #Install ruby2.0-dev
  exec {'apt-get install ruby2.0-dev':
    path    => '/usr/bin',
    command => 'sudo apt-get install -y --force-yes ruby2.0-dev',
    require => Exec['apt-get update'],
  }
  
  #Install rake2.0
  exec {'apt-get install rake':
    path    => '/usr/bin',
    command => 'sudo apt-get install -y --force-yes rake',
    require => Exec['apt-get update'],
    
  }
  
  exec { 'update-alternatives_install_ruby':
	  path      => '/usr/sbin',
	  command   => 'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10',
	  require   => Exec ['apt-get install ruby2.0'],
  }

	exec { 'update-alternatives_install_gems':
	  path      => '/usr/sbin',
	  command   => 'update-alternatives --install /usr/local/bin/gem gem /usr/bin/gem2.0 10',
	  require   => Exec ['apt-get install ruby2.0'],
	}
	
	exec { 'ruby-version':
	  path      => '/usr/bin',
	  command   => 'update-alternatives --set ruby /usr/bin/ruby2.0',
	  user      => root, 
	  require   => Exec['update-alternatives_install_ruby']
	}
	
	exec { 'gem-version':
	  path      => '/usr/bin',
	  command   => 'update-alternatives --set gem /usr/bin/gem2.0',
	  user      => root,
	  require   => Exec['update-alternatives_install_gems']
	}
	
	
	## Nginx
	#=====================================
	
	#include nginx
	
	
	## MySQL
  #=====================================
  
  include mysql

  mysql::db { "$gitlab::gitlab_dbname" :
  ensure    => present,
	  user      => "$gitlab::gitlab_dbuser",
	  password  => "$gitlab::gitlab_dbpwd",
	  host      => "$gitlab::gitlab_dbhost",
	  grant     => ['all'],
	  #TODO: change from all, to just the permissions specififed in the install doc
  }
  
  
  ## Postfix
  #===================================
  
  include postfix
  
}#end packages.pp