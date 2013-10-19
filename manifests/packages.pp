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


	
#	 #Run apt-get update after repo install
#  exec { 'apt-get update':
#    path => '/usr/bin',
#    command => 'apt-get update',
#  } #TODO: use puppetlabs-apt always update resource to manage this
#  
#  
  
	
	## Git v1.7.10 
	#=====================================
	
	include apt

  #Include git ppa (gitlab requires git 1.7.10 or newer which isn't in standard repo)
	apt::ppa { 'ppa:git-core/ppa': 
#	  notify => Exec['apt-get update'],
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
	
	
	
	
	
	## Ruby
	#=====================================
	 
	
	class { 'ruby':
	  ruby_package     => 'ruby1.9.1-full',
	  rubygems_package => 'rubygems1.9.1',
	  rubygems_update  => true,
	  gems_version     => 'latest',
	}
	
	exec {'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10':
	  path   => '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
	  command => 'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10',
	  
	}
	exec {'update-alternatives --set ruby /usr/bin/ruby1.9.1':
	  path   => '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
	  command => 'update-alternatives --set ruby /usr/bin/ruby1.9.1',
	  require => Exec['update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10'],
	  
	}

  

	
	
	## Nginx
	#=====================================
	
	#include nginx
	
	
	## MySQL
  #=====================================
  
  #include mysql #This syntax is no longer supported as of puppetlabs-mysql 2.0.0
  # The end user must manually setup the database, see tests/init.pp for an example

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