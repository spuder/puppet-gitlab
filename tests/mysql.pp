 


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
#mysql::db { "$gitlab::gitlab_dbname" :
#  ensure    => present,
#  user      => "$gitlab::gitlab_dbuser",
#  password  => "$gitlab::gitlab_dbpwd",
#  host      => "$gitlab::gitlab_dbhost",
#  grant     => ['all'],
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
  remove_default_accounts => true,
  restart                 => true,
}
  
   mysql::db { 'spencerTest':
      user     => 'myuser',
      password => 'mypass',
      host     => 'localhost',
      grant    => ['SELECT', 'LOCK TABLES', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP', 'INDEX', 'ALTER'],
  }
  
  #Disables the anonomous accounts, though I am having some issues with it 
  #http://dba.stackexchange.com/questions/51452/how-do-you-disable-anonymous-login-mysql
#  class{ mysql::server::account_security :}


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



#mysql> select user,host,password from mysql.user;
#+------------------+-----------+-------------------------------------------+
#| user             | host      | password                                  |
#+------------------+-----------+-------------------------------------------+
#| root             | localhost | *F3A2A51A9B0F2BE2468926B4132313728C250DBF |
#| root             | gitlab    |                                           |
#| root             | 127.0.0.1 |                                           |
#| root             | ::1       |                                           |
#|                  | localhost |                                           |
#|                  | gitlab    |                                           |
#| debian-sys-maint | localhost | *95C1BF709B26A5BA97ADCD9E902BCAB6E0E91E8B |
#| myuser           | localhost | *6C8989366EAF75BB670AD8EA7A7FC1176A95CEF4 |
#+------------------+-----------+-------------------------------------------+