# Gitlab 7.0  

Source - [https://github.com/spuder/puppet-gitlab](https://github.com/spuder/puppet-gitlab)  
Forge  - [https://forge.puppetlabs.com/spuder/gitlab](https://forge.puppetlabs.com/spuder/gitlab)   



##Overview

Installs Gitlab 7 using the [omnibus installer](https://about.gitlab.com/downloads/)

**Version 2.0 is a complete rewrite with many api breaking changes** 

Since it uses the omnibus installer, it is incompatible with the previous puppet module 

**Upgrading from gitlab 6 is untested.**   
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md


##Setup  

Requires:

    puppet >= 3.0.0
    facter >= 1.7.0

Module Dependencies:

    puppetlabs-stdlib >= 4.0.0

Operating Systems:

    Cent 6.5
    Debian 7.5
    Ubuntu 12.04
    Ubuntu 14.04

--------------------------------------------------------------------------------------


##Usage


###Get up and running quickly

A vagrant file is included to quickly spin up a test vm

    $ vagrant up 
    $ puppet apply /vagrant/tests/init.pp --debug
    # navigate to https://192.168.33.10

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

An example config file with some of the common configurations [is located here:](https://github.com/spuder/puppet-gitlab/blob/master/tests/init.pp)

An example config file with *all* of the available parameters [is located here:](https://github.com/spuder/puppet-gitlab/blob/master/tests/all_parameters_enabled.pp)


##Enterprise

The puppet-gitlab module has limited support for gitlab enterprise installations. You can enable additional enterprise configuration options with the `$gitlab_release` parameter

    class { 'gitlab' : 
      gitlab_branch   => '7.0.0',
      gitlab_release  => 'enterprise',
      # The url (without filename) from where to download gitlab
      gitlab_download_prefix => 'https://downloads-packages.s3.amazonaws.com/'
    }

*Note: Since the author of this module does not have gitlab-enterprise, downloading the enterprise edition is untested and likely will fail. If you are able to test this feature, please contact spuder via github issues, twitter, or irc*

- twitter @spencer450   
- chat.freenode.net #gitlab @spuder


**If download fails, manually place the .rpm or .deb in `/var/tmp`**

Example

    /var/tmp/gitlab-7.0.0_omnibus-1.el6.x86_64.rpm
    /var/tmp/gitlab_7.0.0-omnibus-1_amd64.deb



