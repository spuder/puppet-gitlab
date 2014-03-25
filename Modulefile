name    'spuder-gitlab'
version '1.7.0'
source 'https://github.com/spuder/puppet-gitlab'
author 'spencer owen'
license 'GPLv3'
summary 'Puppet GitLab Module'
description 'gitlab
=========


Source - https://github.com/spuder/puppet-gitlab  
Issues - https://github.com/spuder/puppet-gitlab/issues   
Forge  - https://forge.puppetlabs.com/spuder/gitlab  
Install Video - http://spuder.wordpress.com/2013/10/30/install-gitlab-with-puppet/  
Changelog - https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md  



####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with [Modulename]](#setup)
    * [Beginning with gitlab](#beginning-with-gitlab)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview

Installs Gitlab 6 on Ubuntu

Supported Versions :  

Gitlab 6-0-stable on Ubuntu 12.04  
Gitlab 6-1-stable on Ubuntu 12.04  
Gitlab 6-2-stable on Ubuntu 12.04   
Gitlab 6-3-stable on Ubuntu 12.04  
Gitlab 6-4-stable on Ubuntu 12.04  
Gitlab 6-5-stable on Ubuntu 12.04  
Gitlab 6-6-stable on Ubutnu 12.04  
Gitlab 6-7-stable on Ubuntu 12.04  



##Setup  

Requires puppet 3.0.0 or greater


Requires the following module dependencies   

- puppetlabs-apt    >= 1.0.0
- puppetlabs-mysql  >= 2.0.0  
- puppetlabs-ruby   >= 0.1.0
- puppetlabs-stdlib >= 4.0.0
- example42-postfix >= 2.0.0


--------------------------------------------------------------------------------------


##Usage

###Vagrant

A vagrantfile is included for testing / development  


    $ vagrant up 


###Beginning with gitlab

####Database
To use the module, you must have mysql::server installed and configured with a user. 
It is recommended that this be setup in your site.pp file, hiera or another ENC.


The following would setup mysql, and remove insecure test schema

    root$ puppet module install puppetlabs-mysql

Create a manifest file to install mysql  

    $vim /tmp/gitlab-mysql-prerequisits.pp  
      class { \'::mysql::server\':  
        root_password            => \'correct-horse-battery-staple\' }  
        remove_default_accounts  =>  true,
        restart                  =>  true,
      }  

Then apply the mysql manifest 

    puppet apply /tmp/gitlab-mysql-prerequisits.pp  --debug  

#####Gitlab class parameters  

After the mysql root user has been steup, call the gitlab class with the desired parameters. 
Any parameters omitted will be set to the defaults located in gitlab::params

For example, a basic configuration might look like this: 

      class { \'gitlab\' : 
        git_email              =>  \'git@foo.com\',
        gitlab_branch          =>  \'6-5-stable\',
        gitlab_dbname          =>  \'gitlabdb\',
        gitlab_dbuser          =>  \'gitlabdbu\',
        gitlab_dbpwd           =>  \'changeme\',
        gitlab_projects        =>  \'15\',
        user_changename        =>  true,
        ....
    }

**Look at tests/init.pp for an example of what class parameters to use**

**The install process may take 15 minutes, and may appear to be stuck at the following line; this is normal:**  
 
     Debug: Executing \'/usr/bin/yes yes | bundle exec rake gitlab:setup RAILS_ENV=production\'

####Username & Password

The default username and password are:

    admin@local.host
    5iveL!fe


##Customization

####Login Page  

The login page and the icon in the top left of the profile page can be customized. 

An example to change the landing page icon  

      class { \'gitlab\' : 
          .... 
          use_custom_login_logo  =>  true,
          company_logo_url       =>  \'http://placekitten.com/300/93\',
          use_company_link	     =>  true,
          company_link           =>  \'[Learn more about CompanyName](http://icanhas.cheezburger.com/)\',
        }  
        

        
        
![logo](http://f.cl.ly/items/401M3R213a2H1Z220O07/Image%202013.10.10%2010%3A05%3A33%20AM.png)

--------------------------------------------------------------------------------------

###Thumbnail Icon

To change the thumbnail icon, place two .png files with the following names, into the following folder
 
/home/git/company-logo-white.png  
/home/git/company-logo-black.png  


    class { \'gitlab\' :
      ....
      use_custom_thumbnail  => true,
      ....
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

    class { \'gitlab\' : 
        ......
        ldap_enabled           =>  true,
        ldap_host              =>  \'DC1.microsoft.com\',
        ldap_base              =>  \'DC=microsoft,DC=com\',
        ldap_port              =>  \'636\',
        ldap_uid               =>  \'sAMAccountName\',      #LDAP = \'uid\', AD = \'sAMAccountName\'
        ldap_method            =>  \'ssl\',                 #either ssl or plain
        ldap_bind_dn           =>  \'CN=foo,CN=users,DC=microsoft,DC=com\',  
        ldap_bind_password     =>  \'bar\',
    }
    
**Users must have email addresses defined in AD to be able to login to gitlab!**


### HTTPS (SSL)

Simple example with no encryption (not recommended)  
   
    class { \'gitlab\' :
      ....
      gitlab_ssl      =>  false,
      .....
    }

Simple example with SSL and Self Signed Cert (not recommended for production)  
Ngnix will use the self signed certificate and key located in :  

  certificate = /etc/ssl/certs/ssl-cert-snakeoil.pem  
  private key = /etc/ssl/private/ssl-cert-snakeoil.key  

    class { \'gitlab\' :
      ....
      gitlab_ssl              =>  true
      gitlab_ssl_self_signed  =>  true
      ....
    }

Simple example with Certificate Authority signed Cert (Recommended)   
You will need to place your .pem file and your private key in a location accessible to nxinx

    class { \'gitlab\' : 
      ....
      gitlab_ssl             =>  false
      gitlab_ssl_cert        =>  \'/home/git/foo/bar.pem\'  #Can be .pem or .crt
      gitlab_ssl_key         =>  \'/home/git/foo/bar.key\'
      gitlab_ssl_self_signed =>  false
      ....
    }


##Reference

All of the parameters that can be set

  Gitlab server settings

    gitlab_branch            # Which branch to checkout from gitlab_sources
    gitlabshell_branch       # Which branch to checkout from gitlabshell_sources
    git_user                 # Default is \'git\', changing this is risky! 
    git_home                 # Default /home/git
    git_email                # The email address gitlab will send email from 
    git_comment              # Arbitrary unix identifier, Default \'gitlab\'
    git_ssh_port             # SSH port, Default \'22\'
    gitlab_sources           # git URL with gitlab source
    gitlabshell_sources      # git URL with gitlabshell source

  Database

    gitlab_dbtype            # Only MySQL supported at the moment
    gitlab_dbname            # Name of the schma, Default \'gitlabhq_production\'
    gitlab_dbuser            # User with access to the schema, Default \'gitlab\'
    gitlab_dbpwd             # $gitlab_dbuser database password
    gitlab_dbhost            # Hostname of database server, Default \'localhost\'
    gitlab_dbport            # Default \'3306\'

  Web & Security

    gitlab_ssl               # Boolean if using SSL, Default: false
    gitlab_ssl_cert          # location of ssl certificate Default \'/etc/ssl/certs/ssl-cert-snakeoil.pem\'
    gitlab_ssl_key           # location of ssl key Default \'/etc/ssl/private/ssl-cert-snakeoil.key\'
    gitlab_ssl_self_signed   # If cert is signed by CA or self signed, Default: false
    default_servername       # Subdomain Default \'gitlab\' Example \'gitlab.foo.com\' 

  LDAP

    ldap_enabled             # Default: false          
    ldap_host                # URL of domain controller Default \'ldap.domain.com\'
    ldap_base                # base domain Default \'dc=domain,dc=com\'
    ldap_uid                 # Unix = \'uid\' AD = \'sAMAccountName\'
    ldap_port                # Default: \'636\'
    ldap_method              # Default: ssl
    ldap_bind_dn             # Address of the bind user Default \'\'
    ldap_bind_password       # Password of bind user

  Company Branding

    use_custom_login_logo    # Determins if landing page uses company_logo_url,Default: false
    company_logo_url         # URL that contains a logo, usually about 300 x 90 px
    use_custom_thumbnail     # thumbnail icon are located in /home/git/, Default: false
    use_company_link         # Add arbitrary text under icon
    company_link             # Markdown of any text Example: \'[Learn more about foo](http://failblog.cheezburger.com)\'

  User default settings

    gitlab_gravatar          # Default: true
    user_create_group        # Default: false
    user_changename          # Default: false

  Project default features

    project_issues           # Default: true
    project_merge_request    # Default: true
    project_wiki             # Default: true
    project_wall             # Default: false
    project_snippets         # Default: false
    gitlab_projects          # Default: 15
    visibility_level         # New in 6-4 \'public/internal/private\' Default: internal 


##Limitations

- Works on Debian / Ubuntu systems. CentOS / RHEL not supported

- Modifying $git_user, and $git_home is untested and may have unintended side effects  

- Only supports up to ruby 1.9.3 on Ubuntu 12.04 due to limitation 
of Ubuntu provided packages  
(Will support ruby 2.0 when Ubuntu 14.04 is released)

###Support

Issues page: https://github.com/spuder/puppet-gitlab/issues  
irc: chat.freenode.net room: #gitlab nickname: spuder  
Twitter @spencer450  



##Release Notes/Contributors/Etc 

This module is based on the work done by the following people:  

sbadia - https://github.com/sbadia/puppet-gitlab  
atomaka - https://github.com/atomaka/puppet-gitlab  

The advantages of this puppet module over the work prevously done in other gitlab modules 

- Ability to use older version of gitlab (templates are updated for each release)  
- Ability to brand gitlab with custom logos  
- Better dependency resolution  
- MySQL database automatically created  
- Git and Nginx PPA\'s automatically installed
- Ruby automatically installed  
- Vagrant integration  
- Simplified out out of box expierence  
- Significantly better documentation  




'
project_page 'https://github.com/spuder/puppet-gitlab/blob/master/README.md'

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
dependency 'puppetlabs/apt', '>=1.0.0'
dependency 'puppetlabs/stdlib', '>=4.0.0'
dependency 'example42-postfix', '>=2.0.0'
dependency 'puppetlabs/ruby', '>=0.1.0'
dependency 'puppetlabs/mysql', '>=2.0.0'
dependency 'example42/puppi', '>0.0.1'
