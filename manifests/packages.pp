# init -> packages -> user -> setup -> install -> config -> service
class gitlab::packages inherits gitlab {
  
  include apt
    

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
                    'logrotate',
                    'sudo',
                      ]
  ensure_packages($system_packages)

  ## Git core version > 1.7.10 is now standard
  # =======================================

  package { 'git-core':
    ensure => latest,
  }

  ## Ruby
  # =====================================

  class { 'ruby':
    ruby_package      =>  'ruby1.9.1-full',
    rubygems_package  =>  'rubygems1.9.1',
    rubygems_update   =>  true,
    gems_version      =>  'latest',
  }

  exec {'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10':
    path    =>  '/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command =>  'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10',
    unless  => 'update-alternatives --query ruby | grep -w /usr/bin/ruby1.9.1',
  }

  exec {'update-alternatives --set ruby /usr/bin/ruby1.9.1':
    path    =>  '/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command =>  'update-alternatives --set ruby /usr/bin/ruby1.9.1',
    unless  => 'update-alternatives --get-selections | grep -w /usr/bin/ruby1.9.1',
    require =>  Exec['update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10'],
  }

  exec {'update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 10':
    path    =>  '/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command =>  'update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 10',
    unless  => 'update-alternatives --query gem | grep -w /usr/bin/gem1.9.1',
  }

  exec {'update-alternatives --set gem /usr/bin/gem1.9.1':
    path    =>  '/bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command =>  'update-alternatives --set gem /usr/bin/gem1.9.1',
    unless  => 'update-alternatives --get-selections | grep -w /usr/bin/gem1.9.1',
    require =>  Exec['update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 10'],
  }



  ## MySQL
  # =====================================

  # The end user must manually setup the database
  # see tests/init.pp for an example
  mysql::db { "${gitlab::gitlab_dbname}" :
    ensure    =>  present,
    user      =>  "${gitlab::gitlab_dbuser}",
    password  =>  "${gitlab::gitlab_dbpwd}",
    host      =>  "${gitlab::gitlab_dbhost}",
    grant     =>  ['SELECT', 'LOCK TABLES', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP', 'INDEX', 'ALTER'],
  }


  ## Postfix
  # ===================================
  include postfix


  ## Nginx
  # =========
    
  package { 'nginx':
    ensure  =>  latest,
  }
  
  

}# end packages.pp
