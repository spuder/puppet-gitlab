name    'spuder-gitlab'
version '0.1.0'
source 'https://github.com/spuder/puppet-gitlab'
author 'spencer owen'
license 'GPLv3'
summary 'Puppet GitLab Module'
description '# gitlab #


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
Gitlab 6-1-stable on Ubuntu 12.04

 

##Module Description

This puppet module accomplishes the gitlab 6 installtion tasks outlined in the install.md 
https://github.com/gitlabhq/gitlabhq/blob/6-1-stable/doc/install/installation.md?source=cc





##Setup

###What [Modulename] affects

The module installs the following programs:

installs ruby 2.0 (from saucy ppa\'s)
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

Warning: Failed to match dpkg-query line "No packages found matching mysql-client.\\n"
Warning: Failed to match dpkg-query line "No packages found matching mysql-server.\\n"
Warning: Failed to match dpkg-query line "No packages found matching libxslt1-dev.\\n"
Warning: Failed to match dpkg-query line "No packages found matching python-docutils.\\n"
Warning: Failed to match dpkg-query line "No packages found matching libicu-dev.\\n"
Warning: Failed to match dpkg-query line "No packages found matching git-core.\\n"
http://projects.puppetlabs.com/issues/22621


The install process may take a long time, and may appear to be stuck at the following line for up to 600 seconds: 
Debug: Executing \'/usr/bin/yes yes | bundle exec rake gitlab:setup RAILS_ENV=production\'

After the installation is complete, start the gitlab service

service gitlab start



	
###Beginning with [Modulename]	

To use the module, you must have mysql::server installed and configured with a user. 
It is recomeded that this be setup in your site.pp file, hiera or another ENC.


If you are using puppet stand alone, the following would setup mysql

root$ import module puppetlabs-mysql

root$ cat /tmp/gitlab-mysql-prerequisits.pp
  class { \'mysql::server\':
    config_hash => { \'root_password\' => \'badpassword\' }
  }
  
puppet apply /tmp/gitlab-mysql-prerequisits.pp

  

	 
##Usage


After the mysql root user has been steup, call the gitlab class with the desired parameters. 
Any parameters omitted will be set to the defautls located in gitlab::params

For example, a basic configuraiton might look like this: 

      class { \'gitlab\' : 
	  git_email              => \'git@foo.com\',
	  git_comment            => \'GitLab\',
	  gitlab_branch          => \'6-1-stable\',
	  gitlabshell_branch     => \'v1.7.1\',
	  
	  gitlab_dbname          => \'gitlabdb\',
	  gitlab_dbuser          => \'gitlabdbu\',
	  gitlab_dbpwd           => \'changeme\',
	  

	  gitlab_projects        => \'10\',
	  gitlab_username_change => true,
	  
	  }
	  
	  
##Reference

All of the parameters that can be set



  
    #Gitlab server settings
    $gitlab_branch         
    $gitlabshell_branch     
    $git_user               
    $git_home               
    $git_email              
    $git_comment            
    $gitlab_sources         
    $gitlabshell_sources    
    
    #Database
    $gitlab_dbtype          
    $gitlab_dbname          
    $gitlab_dbuser         
    $gitlab_dbpwd           
    $gitlab_dbhost         
    $gitlab_dbport          
    $gitlab_domain         
    $gitlab_repodir        
    
    #Web & Security
    $gitlab_ssl             
    $gitlab_ssl_cert        
    $gitlab_ssl_key         
    $gitlab_ssl_self_signed 
    
    #LDAP
    $ldap_enabled           
    $ldap_host              
    $ldap_base           
    $ldap_uid              
    $ldap_port          
    $ldap_method         
    $ldap_bind_dn           
    $ldap_bind_password     
    
    #Company Branding
    $use_custom_login_logo 
    $company_logo_url       
    $use_custom_thumbnail  
    
    #User default settings
    $gitlab_gravatar        
    $user_create_group      
    $user_create_team       
    $user_changename        
    
    #Project default features
    $project_issues         
    $project_merge_request  
    $project_wiki           
    $project_wall           
    $project_snippets       
    $gitlab_projects 
    $project_public_default     

	  
	  
##Limitations

Designed and tested for Ubuntu 12.04
Should work on Ubuntu 14.04
May work on Debian 7
Will not work on CentOS / RHEL


##Development

Pull Requests are accepted: 

**Pull requests should be made to the vagrant branch**
Changes will then be merged into the master branch


##Release Notes/Contributors/Etc **Optional**

This module is based on the work done by the following people:

sbadia - https://github.com/sbadia/puppet-gitlab
atomaka - https://github.com/atomaka/puppet-gitlab

##Changelog
2013-Oct-3: First Release, fully tested'
project_page 'https://github.com/spuder/puppet-gitlab/blob/master/README.md'

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
dependency	'puppetlabs/apt', '>= 1.3.0'
