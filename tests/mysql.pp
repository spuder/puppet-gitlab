 


#############################
## Syntax for puppetlabs-mysql < 2.0.0
#############################
#include mysql
#include gitlab #only needed if you want to call gitlab::params
#
#class { 'mysql::server':
#  config_hash => { 'root_password' => 'badpassword' }
#}
#
#mysql::db { "$gitlab::params::gitlab_dbname" :
#  ensure    => present,
#  user      => "$gitlab::params::gitlab_dbuser",
#  password  => "$gitlab::params::gitlab_dbpwd",
#  host      => "$gitlab::params::gitlab_dbhost",
#  grant     => ['all'],
#  #TODO: change from all, to just the permissions specififed in the install doc
#}

################################
## Syntax for  puppetlabs-mysql version > 2.0.0
################################
#https://ask.puppetlabs.com/question/3516/how-to-install-mysql-error-this-class-has-been-deprecated/

##Shorthand way of initializing mysql class
#include ::mysql::server


##Longhand way of initializing mysql class
class { '::mysql::server':
  root_password   => 'foo',
  override_options => { 
      'mysqld' => { 'max_connections' => '1024' } ,
    }
}
#    root_password => 'badpassword',
  
  
   mysql::db { 'spencerTest':
      user     => 'myuser',
      password => 'mypass',
      host     => 'localhost',
      grant    => ['SELECT', 'UPDATE'],
  }


# If you attempt to use the old syntax with the new puppetlabs-mysql module, you will get the following errors. 

#Error: ERROR:  This class has been deprecated and the functionality moved
#    into mysql::server.  If you run mysql::server without correctly calling
#    mysql:: server with the new override_options hash syntax you will revert
#    your MySQL to the stock settings.  Do not proceed without removing this
#    class and using mysql::server correctly.
#
#    If you are brave you may set attempt_compatibility_mode in this class which
#    attempts to automap the previous settings to appropriate calls to
#    mysql::server at /etc/puppet/modules/mysql/manifests/init.pp:89 on node gitlab.localdomain
