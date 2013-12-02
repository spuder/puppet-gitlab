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
                    'nginx',
                      ]
  ensure_packages($system_packages)

  ## Git v1.7.10
  #=====================================

  include apt

  #Include git ppa (gitlab requires git 1.7.10 or newer which isn't in standard repo)
  apt::ppa { 'ppa:git-core/ppa':
  }

  #Install key for repo (otherwise it prints error)
  apt::key { 'ppa:git-core/ppa':
      key   =>  'E1DF1F24',
  }

  package { 'git-core':
    ensure  =>  present,
    require =>  [
        Apt::Ppa['ppa:git-core/ppa'],
        Apt::Key['ppa:git-core/ppa'],
                ],
  }


  ## Ruby
  #=====================================

  class { 'ruby':
    ruby_package      =>  'ruby1.9.1-full',
    rubygems_package  =>  'rubygems1.9.1',
    rubygems_update   =>  true,
    gems_version      =>  'latest',
  }

  exec {'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10':
    path    =>  '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command =>  'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10',
  }

  exec {'update-alternatives --set ruby /usr/bin/ruby1.9.1':
    path    =>  '/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command =>  'update-alternatives --set ruby /usr/bin/ruby1.9.1',
    require =>  Exec['update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10'],
  }



  ## MySQL
  #=====================================

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
  #===================================
  include postfix

}#end packages.pp
