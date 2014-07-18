name    'spuder-gitlab'
version '2.0.1'
source 'https://github.com/spuder/puppet-gitlab'
author 'Spencer Owen'
license 'GPLv3'
summary 'Installs and configures gitlab 7 using omnibus installer'
description '# Gitlab 7.0  
[![Build Status](https://travis-ci.org/spuder/puppet-gitlab.png)](https://travis-ci.org/spuder/puppet-gitlab)

Source - [https://github.com/spuder/puppet-gitlab](https://github.com/spuder/puppet-gitlab)  
Forge  - [https://forge.puppetlabs.com/spuder/gitlab](https://forge.puppetlabs.com/spuder/gitlab)   
Changelog - [https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md](https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md) 



##Overview

Installs Gitlab 7 using the [omnibus installer](https://about.gitlab.com/downloads/)

**Version 2.x.x is a complete rewrite with many api breaking changes. 
Since it uses the omnibus installer, it is incompatible with the previous puppet module.**

If upgrading from gitlab 6, it is recomended that you create a fresh install and [migrate the data.](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md)



##Setup  

Supported Versions:

- puppet >= 3.0.0
- facter >= 1.7.0

Module Dependencies:

- puppetlabs-stdlib >= 4.0.0

Supported Operating Systems:

- Cent 6.5
- Debian 7.5
- Ubuntu 12.04
- Ubuntu 14.04



##Usage


###Get up and running quickly - (testing only)

A vagrant file is included to quickly spin up a test vm. **Do not use vagrant for production**

    $ vagrant up 
    $ sudo puppet apply -e "class { gitlab : puppet_manage_config => true, gitlab_branch => \'7.0.0\', external_url => \'http://192.168.33.10, }" --modulepath=/etc/puppet/modules --verbose


192.168.33.10 is the ip address hard coded in the [Vagrantfile](https://github.com/spuder/puppet-gitlab/blob/master/Vagrantfile). You can replace this with an actual hostname as long as it is routable from your workstation.

![gitlab-login](http://cl.ly/image/463I0m2z1H34/Safari.png)

####Password

The default username and password are:

    admin@local.host
    5iveL!fe

##Parameters

**There are over 100 configuration options that can be configured in /etc/gitlab/gitlab.rb. This puppet module exposes nearly all of them as paramters.**

###See the full documentation of parameters here: [manifsts/params.pp](https://github.com/spuder/puppet-gitlab/blob/master/manifests/params.pp)


Mandatory parameters: 

    $gitlab_branch 
    $external_url

 All other parameters are optional. 



## Examples

BareBones (not recomended)

```
class { \'gitlab\' : 
  puppet_manage_config   => false,
  gitlab_branch          => \'7.0.0\',
  external_url           => \'http://foo.bar\',
}
```

Basic Example with https

```
class { \'gitlab\' : 
  puppet_manage_config   => true,
  puppet_manage_backups  => true,
  gitlab_branch          => \'7.0.0\',
  external_url           => \'http://foo.bar\',
  ssl_certificate        => \'/etc/gitlab/ssl/gitlab.crt\',
  ssl_certificate_key    => \'/etc/gitlab/ssl/gitlab.key\',
  redirect_http_to_https => true,
  backup_keep_time       => 5184000, # In seconds, 5184000 = 60 days
  gitlab_default_projects_limit => 100,
}

```


Ldap with Active Directory
```
class { \'gitlab\' : 
    puppet_manage_config              => true,
    puppet_manage_backups             => true,
    gitlab_branch                     => \'7.0.0\',
    external_url                      => \'http://foo.bar\',
    ldap_enabled                      => true,
    ldap_host                         => \'foo.example.com\',
    ldap_base                         => \'DC=example,DC=com\',
    ldap_port                         => \'636\',
    ldap_uid                          => \'sAMAccountName\',
    ldap_method                       => \'ssl\',       
    ldap_bind_dn                      => \'CN=foobar,CN=users,DC=example,DC=com\', 
    ldap_password                     => \'foobar\',    
    gravatar_enabled                  => true,
    gitlab_default_can_create_group   => false,
    gitlab_username_changing_enabled  => false,
    gitlab_signup_enabled             => false,
    gitlab_default_projects_features_visibility_level => \'internal\',
}
```
This puppet module will convert the puppet parameters into config lines and place them in `/etc/gitlab/gitlab.rb`  
If you would rather manage this file yourself, set `$puppet_manage_config` to false
```
class { \'gitlab\' :
  gitlab_branch           => \'7.0.0\',
  external_url            => \'http://foo.bar\',
  puppet_manage_config    => false,
}
```


More examples can be found in the [tests directory](https://github.com/spuder/puppet-gitlab/blob/master/tests/)


[Example with every parameter enabled](https://github.com/spuder/puppet-gitlab/blob/master/tests/all_parameters_enabled.pp)


###Enterprise

The puppet-gitlab module supports gitlab enterprise installations. You can enable additional enterprise configuration options with the `$gitlab_release` parameter

`$gitlab_download_link` is the full url (including file name) you received when purchasing gitlab enterprise. Required if `$gitlab_release = \'enterprise\'`



    class { \'gitlab\' : 
      gitlab_branch   => \'7.0.0\',
      gitlab_release  => \'enterprise\',
      gitlab_download_link => \'http://foo/bar/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb\'
    }







If for whatever reason you don\'t want puppet to download the omnibus package automatically, 
you could manually place it in `/var/tmp` instead. 

```
$ ls /var/tmp
/var/tmp/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
/var/tmp/gitlab_7.0.0-omnibus-1_amd64.deb
```


##Limitations

1. Does not manage the firewall, run `lokkit -s https -s ssh` or edit iptables. 
2. If `puppet_manage_config = true` (the default setting), then /etc/gitlab/gitlab.rb is configured with an .erb template. Because of the way .erb templates work, lines are inserted at their actual line numbers of the template, not one after another. This results in a lot of empty lines in /etc/gitlab/gitlb.rb. 
3. Assumes that the release number is always 1 in the file name. eg. `gitlab_7.0.0-omnibus-1_amd64.deb`
4. Omniauth and enterprise are not tested. Please submit a github issue if problems are found.
5. Only supports postgres database. Gitlabhq discourages mysql. 
'
project_page 'https://github.com/spuder/puppet-gitlab/blob/master/README.md'

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
dependency 'puppetlabs/stdlib', '>=4.0.0'
