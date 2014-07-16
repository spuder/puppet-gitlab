# Gitlab 7.0  
[![Build Status](https://travis-ci.org/spuder/puppet-gitlab.png)](https://travis-ci.org/spuder/puppet-gitlab)

Source - [https://github.com/spuder/puppet-gitlab](https://github.com/spuder/puppet-gitlab)  
Forge  - [https://forge.puppetlabs.com/spuder/gitlab](https://forge.puppetlabs.com/spuder/gitlab)   



##Overview

Installs Gitlab 7 using the [omnibus installer](https://about.gitlab.com/downloads/)

**Version 2.0.0 is a complete rewrite with many api breaking changes. 
Since it uses the omnibus installer, it is incompatible with the previous puppet module.**

If upgrading from gitlab 6, it is recomended that you create a fresh install and [migrate the data.](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md)



##Setup  

Supported Versions:

    puppet >= 3.0.0
    facter >= 1.7.0

Module Dependencies:

    puppetlabs-stdlib >= 4.0.0

Supported Operating Systems:

    Cent 6.5
    Debian 7.5
    Ubuntu 12.04
    Ubuntu 14.04



##Usage


###Get up and running quickly

A vagrant file is included to quickly spin up a test vm

    $ vagrant up 
    $ sudo puppet apply -e "class { gitlab : puppet_manage_config => true, gitlab_branch => '7.0.0', external_url => 'http://foo.example.com', }" --modulepath=/etc/puppet/modules --verbose
    # navigate to https://192.168.33.10
*(You could alternatively apply one of the test modules)* `sudo puppet apply /vagrant/tests/init.pp --verbose`

####Password

The default username and password are:

    admin@local.host
    5iveL!fe

##Parameters

Nearly every parameter that can be configured in the gitlab config file is available as a module parameter

*A full list of parameters is shown in [manifsts/params.pp](https://github.com/spuder/puppet-gitlab/blob/master/manifests/params.pp)*


Mandatory parameters: `$gitlab_branch`, `$external_url`. All other parameters are optional. 

    class { 'gitlab' : 
      gitlab_branch   => '7.0.0',
      external_url    => 'http://foo.bar',
    }



## Examples

BareBones (not recomended)

```
class { 'gitlab' : 
  puppet_manage_config   => false,
  gitlab_branch          => '7.0.0',
  external_url           => 'http://foo.bar',
}
```

Basic Example with https

```
class { 'gitlab' : 
  puppet_manage_config   => true,
  puppet_manage_backups  => true,
  gitlab_branch          => '7.0.0',
  external_url           => 'http://foo.bar',
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
    gitlab_branch                     => '7.0.0',
    external_url                      => 'http://foo.bar',
    ldap_enabled                      => true,
    ldap_host                         => 'foo.example.com',
    ldap_base                         => 'DC=example,DC=com',
    ldap_port                         => '636',
    ldap_uid                          => 'sAMAccountName',
    ldap_method                       => 'ssl',       
    ldap_bind_dn                      => 'CN=foobar,CN=users,DC=example,DC=com', 
    ldap_password                     => 'foobar',    
    gravatar_enabled                  => true,
    gitlab_default_can_create_group   => false,
    gitlab_username_changing_enabled  => false,
    gitlab_signup_enabled             => false,
    gitlab_default_projects_features_visibility_level => 'internal',
}
```
This puppet module will convert the puppet parameters into config lines and place them in `/etc/gitlab/gitlab.rb`  
If you would rather manage this file yourself, set `$puppet_manage_config` to false
```
class { 'gitlab' :
  gitlab_branch           => '7.0.0',
  external_url            => 'http://foo.bar',
  puppet_manage_config    => false,
}
```


More examples can be found in the [tests directory](https://github.com/spuder/puppet-gitlab/blob/master/tests/)


[Every Paramter Imaginable](https://github.com/spuder/puppet-gitlab/blob/master/tests/all_parameters_enabled.pp)


###Enterprise

The puppet-gitlab module supports gitlab enterprise installations. You can enable additional enterprise configuration options with the `$gitlab_release` parameter

    class { 'gitlab' : 
      gitlab_branch   => '7.0.0',
      gitlab_release  => 'enterprise',
      gitlab_download_link => 'http://foo/bar/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb
      # gitlab_download_link is the full url you received when purchasing gitlab enterprise
      # gitlab_download_link is required if $gitlab_release = 'enterprise'
    }


If for whatever reason you don't want puppet to download the omnibus package automatically, 
you could manually place it in `/var/tmp` instead. 

Example
```
$ ls /var/tmp
/var/tmp/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
/var/tmp/gitlab_7.0.0-omnibus-1_amd64.deb
```


##Limitations

1. Does not manage the firewall, run `lokkit -s https -s ssh` or edit iptables. 
2. If `puppet_manage_config = true` (the default setting), then /etc/gitlab/gitlab.rb is configured with an .erb template. Because of the way .erb templates work, lines are inserted at their actual line numbers of the template, not one after another. This results in a lot of empty lines. 


