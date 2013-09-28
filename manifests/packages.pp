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
  }
  
  
  
	
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
	#Ubuntu 12.04 doesn't come with ruby2.0, stole .deb files from saucy repo
	file { '/etc/apt/sources.list.d/ruby2.0.list':
	  content => "deb file:///vagrant/files/ruby2-repo /",
	  #TODO: Create a public link that contains the repo
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
  exec {'apt-get instal ruby2.0-dev':
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

  mysql::db { "$gitlab::params::gitlab_dbname" :
  ensure    => present,
	  user      => "$gitlab::params::gitlab_dbuser",
	  password  => "$gitlab::params::gitlab_dbpwd",
	  host      => "$gitlab::params::gitlab_dbhost",
	  grant     => ['all'],
	  #TODO: change from all, to just the permissions specififed in the install doc
  }#TODO test this syntax
  
  
  ## Postfix
  #===================================
  
  include postfix
  
}#end packages.pp