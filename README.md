# gitlab #


####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
    * [What [Modulename] affects](#what-[modulename]-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with [Modulename]](#beginning-with-[Modulename])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The spencerowen-puppet module installs a fully self contained gitlab server on an ubuntu server

Tested :
Gitlab 6-0-stable on Ubuntu 12.04

 

##Module Description

This puppet module accomplishes the gitlab 6 installtion tasks outlined in the install.md 
https://github.com/gitlabhq/gitlabhq/blob/6-1-stable/doc/install/installation.md?source=cc





##Setup

###What [Modulename] affects

The module installs the following programs:

installs ruby 2.0 (from saucy ppa's)
nginx server
postfix server
mysql server

The module configures the following files:

/home/git/gitlab/config/gitlab.yml
/home/git/gitlab/config/database.yml
/home/git/gitlab/config/unicorn.rb
/home/git/gitlab-shell/config.yml
/etc/init.d/gitlab
/etc/ngnix/sites-available/gitlab
/etc/nginx/sites-enabled/gitlab

###Setup Requirements **OPTIONAL**

This module requires the following programs

puppet >= 3.3.0
ruby   >= 2.0 (installed automatically)


This module requires the following modules to be defined in the puppet master

puppet module install puppetlabs-apt
puppet module install puppetlabs-mysql
puppet module install example42/postfix
puppet module install jfryman-nginx


The following dependencies should be resolved automatically

git  		>=1.7.10
ruby 		>=2.0.0
- bundler
- mysql2
-ruby2.0
-charlock_holmes
mysqlserver
mysqlclient
ngnix
postfix


You can safely ignore the following warnings that are presented durring installation
Certain versions of puppet return these errors even though the packages were installed properly

Warning: Failed to match dpkg-query line "No packages found matching mysql-client.\n"
Warning: Failed to match dpkg-query line "No packages found matching mysql-server.\n"
Warning: Failed to match dpkg-query line "No packages found matching libxslt1-dev.\n"
Warning: Failed to match dpkg-query line "No packages found matching python-docutils.\n"
Warning: Failed to match dpkg-query line "No packages found matching libicu-dev.\n"
Warning: Failed to match dpkg-query line "No packages found matching git-core.\n"
http://projects.puppetlabs.com/issues/22621


	
###Beginning with [Modulename]	

To use the module, you must have mysql::server installed and configured with a user. 
It is recomeded that this be setup in your site.pp file, hiera or another ENC.


If you are using puppet stand alone, the following would setup mysql

root$ import module puppetlabs-mysql

root$ cat /tmp/gitlab-mysql-prerequisits.pp
  class { 'mysql::server':
    config_hash => { 'root_password' => 'badpassword' }
  }
  
puppet apply /tmp/gitlab-mysql-prerequisits.pp

  

	 
##Usage


After the mysql root user has been steup, call the gitlab class with the desired parameters. 
Any parameters omitted will be set to the defautls located in gitlab::params

For example, a basic configuraiton might look like this: 

  class { 'gitlab' : 
	  git_email              => 'git@foo.com',
	  git_comment            => 'GitLab',
	  gitlab_branch          => '6-1-stable',
	  gitlabshell_branch     => 'v1.7.1',
	  
	  gitlab_dbname          => 'gitlabdb',
	  gitlab_dbuser          => 'gitlabdbu',
	  gitlab_dbpwd           => 'changeme',
	  
	  gitlab_ssl             => false,
	  gitlab_ssl_cert        => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
	  gitlab_ssl_key         => '/etc/ssl/private/ssl-cert-snakeoil.key',
	  gitlab_ssl_self_signed => false,
	  gitlab_projects        => '10',
	  gitlab_username_change => true,
	  
	  ldap_enabled           => false,
	  ldap_host              => 'ldap.domain.com',
	  ldap_base              => 'dc=domain,dc=com',
	  ldap_uid               => 'uid',
	  ldap_method            => 'ssl',
	  ldap_bind_dn           => 'foo',
	  ldap_bind_password     => 'bar',
	  }
	  
	  
##Reference

All of the parameters that can be set
(Subject to change)

  class { 'gitlab' : 
	  git_user               => 'git',
	  git_home               => '/home/git',
	  git_email              => 'git@adaptivecomputing.com',
	  git_comment            => 'GitLab',
	  gitlab_sources         => 'git://github.com/gitlabhq/gitlabhq.git',
	  gitlab_branch          => '6-1-stable',
	  gitlabshell_sources    => 'git://github.com/gitlabhq/gitlab-shell.git',
	  gitlabshell_branch     => 'v1.7.1',
	  
	  gitlab_dbtype          => 'mysql',
	  gitlab_dbname          => 'gitlabdb',
	  gitlab_dbuser          => 'gitlabdbu',
	  gitlab_dbpwd           => 'changeme',
	  gitlab_dbhost          => 'localhost',
	  gitlab_dbport          => '3306',
	  gitlab_domain          => $::fqdn,
	  gitlab_repodir         => $git_home,#TODO: Can this be removed? 
	  gitlab_ssl             => false,
	  gitlab_ssl_cert        => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
	  gitlab_ssl_key         => '/etc/ssl/private/ssl-cert-snakeoil.key',
	  gitlab_ssl_self_signed => false,
	  gitlab_projects        => '10',
	  gitlab_username_change => true,
	  
	  ldap_enabled           => false,
	  ldap_host              => 'ldap.domain.com',
	  ldap_base              => 'dc=domain,dc=com',
	  ldap_uid               => 'uid',
	  ldap_port              => '636',
	  ldap_method            => 'ssl',
	  ldap_bind_dn           => '',
	  ldap_bind_password     => '',
	  }
	  
	  
##Limitations

Designed and tested for Ubuntu 12.04
Should work on Ubuntu 14.04
May work on Debian 7
Will not work on CentOS / RHEL


##Development

Pull Requests are accepted: 
Please include the following information:

**Pull requests should be made to the vagrant branch**
Changes will then be merged into the master branch

Please include the following: 

Current Git commit
Os teseted
Output before and output after the patch

##Release Notes/Contributors/Etc **Optional**

This module is based on the work done by the following people:

sbadia - https://github.com/sbadia/puppet-gitlab
atomaka - https://github.com/atomaka/puppet-gitlab

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 