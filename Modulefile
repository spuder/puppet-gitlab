name    'spuder-gitlab'
version '2.0.2'
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

If upgrading from Gitlab 6.x, it is recomended that you create a fresh install and [migrate the data.](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md)



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

Use Vagrant to quickly spin up a non production, test vm. 

    $ vagrant up 
    $ vagrant ssh
    $ sudo puppet apply -e "class { gitlab : puppet_manage_config => true, gitlab_branch => \'7.0.0\', external_url => \'http://192.168.33.10\', }" --modulepath=/etc/puppet/modules --verbose

192.168.33.10 is the default ip address in the [Vagrantfile](https://github.com/spuder/puppet-gitlab/blob/master/Vagrantfile).

![gitlab-login](http://cl.ly/image/463I0m2z1H34/Safari.png)

####Password

The default username and password are:

    admin@local.host
    5iveL!fe

####Download

This puppet module will automatically download the appropriate gitlab package based on `$gitlab_branch` and detected operatingsystem.  
Gitlab enterprise specific downloads are covered later in this readme.


If for whatever reason you don\'t want puppet to download the omnibus package automatically, 
you could manually place it in `/var/tmp` instead. 

```
$ ls /var/tmp
/var/tmp/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
/var/tmp/gitlab_7.0.0-omnibus-1_amd64.deb
```


##Parameters

**There are over [100 configuration options](https://github.com/gitlabhq/gitlabhq/blob/master/config/gitlab.yml.example) in /etc/gitlab/gitlab.rb. This puppet module exposes nearly all of them as class paramters.**

### [Parameter documentation](https://github.com/spuder/puppet-gitlab/blob/master/manifests/params.pp)

Mandatory parameters: 

    $gitlab_branch 
    $external_url

 All other parameters are optional. 



### Example Parameters

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
  external_url           => \'http://gitlab.example.com\',
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
    external_url                      => \'http://gitlab.example.com\',
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

More examples can be found in the [tests directory](https://github.com/spuder/puppet-gitlab/blob/master/tests/). User submitted examples are welcome. 

## Configuration  
 

This puppet module manages the `/etc/gitlab/gitlab.rb` file and leverages omnibus to apply the configuration. Nearly all of the config options are available as puppet class parameters. 
  
If you would rather manage `/etc/gitlab/gitlab.rb` manually, set `$puppet_manage_config` to false
```
class { \'gitlab\' :
  gitlab_branch           => \'7.0.0\',
  external_url            => \'http://foo.bar\',
  puppet_manage_config    => false,
}
```




###Enterprise

This puppet module supports gitlab enterprise installations. You can enable additional enterprise configuration options with the `$gitlab_release` parameter

**Enterprise users must specify the secret download link and filename provided by gitlabhq.**

**Example**  

    class { \'gitlab\' : 
      gitlab_branch   => \'7.0.0\',
      gitlab_release  => \'enterprise\',
      gitlab_download_link => \'http://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb\'
    }





##Limitations

1. Does not manage the firewall, run `lokkit -s https -s ssh` or edit iptables. 
2. If `puppet_manage_config = true` (the default setting), then /etc/gitlab/gitlab.rb is configured with an .erb template. Because of the way .erb templates work, lines are inserted at their actual line numbers of the template, not one after another. This results in a lot of empty lines in /etc/gitlab/gitlb.rb. 
3. Assumes that the release number is always 1 in the file name. eg. `gitlab_7.0.0-omnibus-1_amd64.deb`
4. Omniauth and enterprise are not tested. Please submit a github issue if problems are found.
5. Only supports omnibus provided nginx and postgres services. Apache and MySQL are not available. 

#### Contact  
twitter => [@spencer450](https://twitter.com/spencer450)   
github  => [spuder](https://github.com/spuder)  
linkedin => [Spencer](http://www.linkedin.com/pub/spencer-owen/7/7a1/35/)  
irc     => spuder  



'
project_page 'https://github.com/spuder/puppet-gitlab/blob/master/README.md'

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
dependency 'puppetlabs/stdlib', '>=4.0.0'
