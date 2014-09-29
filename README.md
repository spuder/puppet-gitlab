# Gitlab 7.0  
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
- Cent 7
- Debian 7.5
- Ubuntu 12.04
- Ubuntu 14.04


##Usage


###Get up and running quickly - (testing only)

Use Vagrant to quickly spin up a non production, test vm. 

    $ vagrant up 
    $ vagrant ssh
    $ sudo puppet apply -e "class { gitlab : puppet_manage_config => true, gitlab_branch => '7.0.0', external_url => 'http://192.168.33.10', }" --modulepath=/etc/puppet/modules --verbose

192.168.33.10 is the default ip address in the [Vagrantfile](https://github.com/spuder/puppet-gitlab/blob/master/Vagrantfile).

![gitlab-login](http://cl.ly/image/463I0m2z1H34/Safari.png)

####Password

The default username and password are:

    root
    5iveL!fe

####Download

This puppet module will attempt to download the correct version of gitlab from [the gitlab downloads page](https://about.gitlab.com/downloads/)

If using Gitlab enterprise, or wish to download from an alterative location, populate the `$gitlab_download_link` parameter

    gitlab_download_link => 'https://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb'

Additional Gitlab enterprise specific download information is covered later in this readme.


If for whatever reason you don't want puppet to download the omnibus package automatically, 
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

    gitlab_branch 
    external_url

 All other parameters are optional. 



### Example Parameters

BareBones (not recomended)

```
class { 'gitlab' : 
  puppet_manage_config   => false,
  gitlab_branch          => '7.0.0',
  external_url           => 'http://gitlab.example.com',
}
```

Basic Example with https

```
class { 'gitlab' : 
  puppet_manage_config   => true,
  puppet_manage_backups  => true,
  puppet_manage_packages => true,
  gitlab_branch          => '7.0.0',
  external_url           => 'http://gitlab.example.com',
  ssl_certificate        => '/etc/gitlab/ssl/gitlab.crt',
  ssl_certificate_key    => '/etc/gitlab/ssl/gitlab.key',
  redirect_http_to_https => true,
  backup_keep_time       => 5184000, # In seconds, 5184000 = 60 days
  gitlab_default_projects_limit => 100,
}
```


Ldap with Active Directory
```
class { 'gitlab' : 
    puppet_manage_config              => true,
    puppet_manage_backups             => true,
    puppet_manage_packages            => true,
    gitlab_branch                     => '7.0.0',
    external_url                      => 'http://gitlab.example.com',
    ldap_enabled                      => true,
    ldap_host                         => 'foo.example.com',
    ldap_base                         => 'DC=example,DC=com',
    ldap_port                         => '636',
    ldap_uid                          => 'sAMAccountName',
    ldap_method                       => 'ssl',       
    ldap_bind_dn                      => 'CN=foobar,CN=users,DC=example,DC=com', 
    ldap_password                     => 'correct-horse-battery-staple',    
    gravatar_enabled                  => true,
    gitlab_default_can_create_group   => false,
    gitlab_username_changing_enabled  => false,
    gitlab_signup_enabled             => false,
    gitlab_default_projects_features_visibility_level => 'internal',
}
```

Manage packages, backups and config file manually
```
class { 'gitlab' : 
  puppet_manage_config   => false,
  puppet_manage_backups  => false,
  puppet_manage_packages => false,
  gitlab_branch          => '7.0.0',
  external_url           => 'http://gitlab.example.com',
}
```
More parameter examples can be found in the [tests directory](https://github.com/spuder/puppet-gitlab/blob/master/tests/).  
User submitted examples are welcome. 


### Wrapper classes & hiera

The parameters above are typically placed inside a wrapper puppet module, or inside the nodes.pp file. 

You can alternativly put the parameters inside hiera. This has the advantage of keeping your wrapper puppet module (or nodes.pp file) clean, and also keeps things like passwords outside of version control. 

gitlab.example.com.yaml
```
---
gitlab:
  puppet_manage_config:   true
  puppet_manage_backups:  true
  puppet_manage_packages: true
  gitlab_branch: 7.2.0
  gitlab_release: basic
  external_url: gitlab.example.com
  ldap_enabled: true
  ldap_password: correct-horse-battery-staple
```
[Example hiera config file:](https://github.com/spuder/puppet-gitlab/tree/master/tests/hiera.example.com.yaml)



## Configuration  
 

This puppet module manages the `/etc/gitlab/gitlab.rb` file and leverages omnibus to apply the configuration. Nearly all of the config options are available as puppet class parameters. 
  
If you would rather manage `/etc/gitlab/gitlab.rb` manually, set `$puppet_manage_config` to false
```
class { 'gitlab' :
  gitlab_branch           => '7.0.0',
  external_url            => 'http://foo.bar',
  puppet_manage_config    => false,
}
```
[Manage /etc/gitlab/gitlab.rb manually](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md)



###Enterprise

This puppet module supports gitlab enterprise installations. There are several parameters only available when `gitlab_release => enterprise`

**Enterprise users must specify the secret download link and filename provided by gitlabhq.**

**Example**  

```
class { 'gitlab' : 
  gitlab_branch        => '7.0.0',
  gitlab_release       => 'enterprise',
  gitlab_download_link => 'http://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb'
  
  # Enterprise only features
  ldap_group_base       => 'OU=groups,DC=mycorp,DC=com',
  ldap_user_filter      => '(memberOf=CN=my department,OU=groups,DC=mycorp,DC=com)',
  ldap_sync_ssh_keys    => 'sshpublickey',
  udp_log_shipping_host => '192.0.2.0',
  udp_log_shipping_port => '1234',
}
```



## Upgrade

Puppet will always ensure that the latest version of the gitlab package is installed. 
To upgrade:

1. Verify a current backup is present. See [Offical Instructions](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/backup_restore.md)
2. Stop gitlab with `gitlab-ctl stop` see [issue #7902](https://github.com/gitlabhq/gitlabhq/issues/7902)
2. Change the `gitlab_branch` parameter to the new version (e.g. 7.1.0 -> 7.2.0)
3. Wait for next puppet run
4. You may need to restart gitlab `sudo gitlab-ctl restart`

*Note: Puppet can automatically manage backups if* `puppet_manage_backups => true`

##Limitations

1. Does not manage the firewall, run `lokkit -s https -s ssh` or edit iptables. 
2. When attempting to autodownload, assumes that the release number is always 1 in the file name. eg. `gitlab_7.0.0-omnibus-1_amd64.deb`
3. Omniauth and enterprise are not tested. Please submit a github issue if problems are found.
4. Only supports omnibus provided nginx and postgres services. Apache and MySQL are not available. 

#### Contact  
twitter => [@spencer450](https://twitter.com/spencer450)   
github  => [spuder](https://github.com/spuder)  
linkedin => [Spencer](http://www.linkedin.com/pub/spencer-owen/7/7a1/35/)  
irc     => spuder  



