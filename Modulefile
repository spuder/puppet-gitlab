name    'spuder-gitlab'
version '2.0.0'
source 'https://github.com/spuder/puppet-gitlab'
author 'Spencer Owen'
license 'GPLv3'
summary 'Installs and configures gitlab 7 using omnibus installer'
description '# Gitlab 7.0  

Source - [https://github.com/spuder/puppet-gitlab](https://github.com/spuder/puppet-gitlab)  
Issues - [https://github.com/spuder/puppet-gitlab/issues](https://github.com/spuder/puppet-gitlab/issues)    
Forge  - [https://forge.puppetlabs.com/spuder/gitlab](https://forge.puppetlabs.com/spuder/gitlab)   
Changelog - [https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md](https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md)    



##Overview

Installs Gitlab 7 using the [omnibus installer](https://about.gitlab.com/downloads/)

*Version 2.0 is a complete rewrite with many api breaking changes*
Since it uses the omnibus installer it is incompatible with the previous puppet module 
You must install gitlab 7 on a new system (no upgrades)
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md


##Setup  

Requires puppet 3.0.0 or greater

Requires the following module dependencies   


- puppetlabs-stdlib >= 4.0.0


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


Nearly every parameter that can be configured in the gitlab config file is available as a module parameter

*A full list of parameters is shown in [manifsts/params.pp](https://github.com/spuder/puppet-gitlab/blob/master/manifests/params.pp)*


Only the following parameters are required

    class { \'gitlab\' : 
      gitlab_branch   => \'7.0.0\',
      external_url    => \'http://foo.bar\',
    }

An example config file with some of the common configurations [is located here:](https://github.com/spuder/puppet-gitlab/blob/master/tests/init.pp)

An example config file with all of the available parameters [is located here:](https://github.com/spuder/puppet-gitlab/blob/master/tests/all_parameters_enabled.pp)






'
project_page 'https://github.com/spuder/puppet-gitlab/blob/master/README.md'

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
dependency 'puppetlabs/stdlib', '>=4.0.0'
