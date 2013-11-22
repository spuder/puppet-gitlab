gitlab
=========


Source - https://github.com/spuder/puppet-gitlab  
Issues - https://github.com/spuder/puppet-gitlab/issues   
Forge  - https://forge.puppetlabs.com/spuder/gitlab  
Upgrade  - https://github.com/spuder/puppet-gitlab/blob/dev/doc/upgrade-checklist.md 
Install Video - http://spuder.wordpress.com/2013/10/30/install-gitlab-with-puppet/



####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with [Modulename]](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with gitlab](#beginning-with-gitlab)
3. [Usage - Configuration options and additional functionalityy](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview

Installs Gitlab 6 on Ubuntu

Supported Versions :  

Gitlab 6-0-stable on Ubuntu 12.04  
Gitlab 6-1-stable on Ubuntu 12.04  
Gitlab 6-2-stable on Ubuntu 12.04   
Gitlab 6-3-stable on Ubuntu 12.04  

See https://github.com/gitlabhq/gitlabhq/blob/6-1-stable/doc/install/installation.md?source=cc


##Setup

The module configures the following files:  

/home/git/gitlab/config/gitlab.yml  
/home/git/gitlab/config/database.yml  
/home/git/gitlab/config/unicorn.rb  
/home/git/gitlab-shell/config.yml  
/etc/init.d/gitlab  
/etc/ngnix/sites-available/gitlab  
/etc/nginx/sites-enabled/gitlab  

###Setup Requirements

This module requires the following programs

- puppet >= 3.0.0  

This module requires the following modules  

- puppetlabs-apt  
- puppetlabs-mysql >= 2.0.0  


--------------------------------------------------------------------------------------

	 
##Usage


###Beginning with gitlab

####Database
To use the module, you must have mysql::server installed and configured with a user. 
It is recommended that this be setup in your site.pp file, hiera or another ENC.


The following would setup mysql, and remove insecure test schema

    root$ import module puppetlabs-mysql

    root$ cat /tmp/gitlab-mysql-prerequisits.pp  
      class { '::mysql::server':  
        root_password => 'somesuperlongpasswordwithentropy' }  
        remove_default_accounts => true,
  		restart                 => true,
      }  

Then apply the config like so  

    puppet apply /tmp/gitlab-mysql-prerequisits.pp  --debug
    

#####Gitlab class parameters
After the mysql root user has been steup, call the gitlab class with the desired parameters. 
Any parameters omitted will be set to the defaults located in gitlab::params

For example, a basic configuration might look like this: 

      class { 'gitlab' : 
	      git_email              => 'git@foo.com',
	      gitlab_branch          => '6-2-stable',
	      gitlab_dbname          => 'gitlabdb',
	      gitlab_dbuser          => 'gitlabdbu',
	      gitlab_dbpwd           => 'changeme',
	      gitlab_projects        => '10',
	      gitlab_username_change => true,
	  }
	  
**Look at tests/init.pp for an example of what class parameters to use**

**The install process may take a long time, and may appear to be stuck at the following line for about 800 seconds:**   
    Debug: Executing '/usr/bin/yes yes | bundle exec rake gitlab:setup RAILS_ENV=production'


##Customization

####Login Page  

The login page and the icon in the top left of the profile page can be customized. 

An example to change the landing page icon  

      class { 'gitlab' : 
          .... 
          use_custom_login_logo  => true,
          company_logo_url       => 'http://placekitten.com/300/93',
          use_company_link	     =>  true,
          company_link           => '[Learn more about CompanyName](http://icanhas.cheezburger.com/)',
        }  
        

        
        
![logo](http://f.cl.ly/items/401M3R213a2H1Z220O07/Image%202013.10.10%2010%3A05%3A33%20AM.png)

--------------------------------------------------------------------------------------

###Thumbnail Icon

To change the thumbnail icon, place two .png files with the following names, into the following folder
 
/home/git/company-logo-white.png  
/home/git/company-logo-black.png     




    class { 'gitlab' :
        use_custom_thumbnail  => true,
    }

![thumbnail](http://f.cl.ly/items/2l2L1t1u3X0n0s350Y1I/Image%202013.10.10%2010%3A31%3A54%20AM.png)
	  
company-logo-white.png is used against the dark background themes  
company-logo-black.png is used against the light background themes 

*The logos should be about 80px by 80px in size*  
*The logos should be saved as a .png* 

**You will need to restart the gitlab server, and clear your browsers cache before**
**the changes will be applied**


###LDAP / AD 

An example to integrate with Active Directory

    class { 'gitlab' : 
        ......
        ldap_enabled           => true,
        ldap_host              => 'DC1.microsoft.com',
        ldap_base              => 'DC=microsoft,DC=com',
        ldap_port              => '636',
        ldap_uid               => 'sAMAccountName',      #LDAP = 'uid', AD = 'sAMAccountName'
        ldap_method            => 'ssl',                 #either ssl or plain
        ldap_bind_dn           => 'CN=foo,CN=users,DC=microsoft,DC=com',  
        ldap_bind_password     => 'bar',
    }
    
**Users must have email addresses defined in AD to be able to login to gitlab!**


### HTTPS (SSL)

Simple example with no encryption (not recommended)  
   
    class { 'gitlab' :
    ....
      $gitlab_ssl             = false
    }

Simple example with SSL and Self Signed Cert (not recommended for production)  
Ngnix will use the certificate and key located in :   

  certificate = /etc/ssl/certs/ssl-cert-snakeoil.pem
  private key = /etc/ssl/private/ssl-cert-snakeoil.key  
  
    class { 'gitlab' :
    ....
      $gitlab_ssl             = true
      $gitlab_ssl_self_signed = true
    }
    
Simple example with Certificate Authority signed Cert (Recommended)   
You will need to place your .pem file and your private key in a location accessible to nxinx
 
    class { 'gitlab' : 
       $gitlab_ssl             = false
        $gitlab_ssl_cert        = '/home/git/foo/bar.pem'  #Can be .pem or .crt
        $gitlab_ssl_key         = '/home/git/foo/bar.key'
        $gitlab_ssl_self_signed = false
    }
  
	  
##Reference

All of the parameters that can be set

  
      #Gitlab server settings
    $gitlab_branch         		#Which branch to checkout from $gitlab_sources
    $gitlabshell_branch     	#Which branch to checkout from $gitlabshell_sources
    $git_user               	#Default is 'git', changing this is risky! 
    $git_home               	#Default /home/git
    $git_email              	#The email address gitlab will send email from 
    $git_comment            	#Arbitrary unix identifier, Default 'gitlab'
    $gitlab_sources         	#git URL with gitlab source
    $gitlabshell_sources    	#git URL with gitlabshell source
    
      #Database
    $gitlab_dbtype          	#Only MySQL supported at the moment
    $gitlab_dbname          	#Name of the schma, Default 'gitlabhq_production'
    $gitlab_dbuser         		#User with access to the schema, Default 'gitlab'
    $gitlab_dbpwd           	#$gitlab_dbuser database password
    $gitlab_dbhost         		#Hostname of database server, Default 'localhost'
    $gitlab_dbport          	#Default '3306'
    
      #Web & Security
    $gitlab_ssl             	#Boolean if using SSL Default false
    $gitlab_ssl_cert        	#location of ssl certificate Default '/etc/ssl/certs/ssl-cert-snakeoil.pem'
    $gitlab_ssl_key         	#location of ssl key Default '/etc/ssl/private/ssl-cert-snakeoil.key'
    $gitlab_ssl_self_signed 	#If cert is signed by CA or self signed, Default: false
    $default_servername 		#Subdomain Default 'gitlab' Example 'gitlab.foo.com' 
    
      #LDAP
    $ldap_enabled 				#Default false          
    $ldap_host              	#URL of domain controller Default 'ldap.domain.com'
    $ldap_base           		#base domain Default 'dc=domain,dc=com'
    $ldap_uid              		#Unix = 'uid' AD = 'sAMAccountName'
    $ldap_port          		#Default '636'
    $ldap_method         		#Default ssl
    $ldap_bind_dn           	#Address of the bind user Default ''
    $ldap_bind_password     	#Password of bind user
    
      #Company Branding
    $use_custom_login_logo 		#Boolean, if landing page should use $company_logo_url Default: false
    $company_logo_url       	#URL that contains a logo, usually about 300 x 90 px
    $use_custom_thumbnail  		#Boolean, thumbnail icon are located in /home/git/
    #use_company_link			#Add arbitrary text under icon
    #company_link				#Markdown of any text Example: '[Learn more about foo](http://failblog.cheezburger.com)'
    
     #User default settings
    $gitlab_gravatar        	#Default: true
    $user_create_group      	#Default: false
    $user_changename        	#Default: false
    
      #Project default features
    $project_issues         	#Default: true
    $project_merge_request  	#Default: true
    $project_wiki           	#Default: true
    $project_wall           	#Default: false
    $project_snippets       	#Default: false
    $gitlab_projects 			#Default: 10
    $project_public_default     #Default: true #Broken until gitlab fixes https://github.com/gitlabhq/gitlabhq/issues/5462  

	  
	  
##Limitations

Will not work on CentOS / RHEL  (yet)

Modifying $git_user, and $git_home is untested and may have unintended side effects  


###Support

Issues page: https://github.com/spuder/puppet-gitlab/issues 


##Release Notes/Contributors/Etc 

This module is based on the work done by the following people:  

sbadia - https://github.com/sbadia/puppet-gitlab  
atomaka - https://github.com/atomaka/puppet-gitlab  

##Changelog
2013-Oct-3: 0.1.0 First Release, fully tested  
2013-Oct-5: 0.2.0 Removes ruby repo from files, and instead downloads from web  
2013-Oct-5: 0.2.1 Adds module dependencies   
2013-Oct-7: 0.2.2 Fixes puppetlabs-mysql api change https://github.com/spuder/puppet-gitlab/issues/1  
2013-Oct-9: 0.2.3 Changes puppetlabs-apt dependency from 1.3.0 to 1.0.0   
2013-Oct-9: 0.2.4 Fixes backup issue when replacing thumbnail icons https://github.com/spuder/puppet-gitlab/issues/8   
2013-Oct-10: 0.2.5 Fixes thumbnail issue  
2013-Oct-10: 0.3.0 Adds HTTPS Support, Updates Readme with links  
2013-Oct-18: 0.3.1 Fixes issue where the thumbnail icon would be overwritten https://github.com/spuder/puppet-gitlab/issues/14  
2013-Oct-21: 1.0.0  Major Release

- Rewrite of the ruby module, now uses puppetlabs-ruby instead of custom package https://github.com/spuder/puppet-gitlab/issues/5 
- company_url now takes the entire markup instead of just the link. See gitlab.yml6-x-stable.erb 
- Removed unused parameters $gitlab_repodir, $gitlab_domain
- Indentation & syntax changes to conform to puppet lint https://github.com/spuder/puppet-gitlab/issues/19
- Increases security on database permissions https://github.com/spuder/puppet-gitlab/issues/16
- Changes git user from disabled to locked https://github.com/spuder/puppet-gitlab/issues/9
- Fixed issue where init script was modified as work around https://github.com/spuder/puppet-gitlab/issues/12
- Removes dependency on wget module
- Removes dependency on unused nginx module
- Removes $user_create_team  as 6.x no longer has concept of teams
- Adds http redirect in nginx, and other security improvements   
  
2013-Nov-1: 1.1.0 Adds new flag $default_servername, allows user to choose what subdomain gitlab is configured as in nginx
Instead of gitlab.foo.com, user can now make the url git.foo.com or any other subdomain  
2013-Nov-11: 1.1.1 Increases default gitlabshell from 1.7.1 to 1.7.4, default branch is now 6-2-stable  
2013-Nov-14: 1.1.2 Increases default gitlabshell from 1.7.4 to 1.7.8, as a result of a security vulnerability  
2013-Nov-20: 1.1.3 Includes work around for issue where project would always be made public https://github.com/gitlabhq/gitlabhq/issues/5462  
2013-Nov-22: 1.2.0 Fixes bug where gitlab-shell would reset to the master branch, Adds support for 6-3-stable



