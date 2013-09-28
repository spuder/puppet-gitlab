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

Installs gitlab 6 on a Ubuntu 12.04 server. 

##Module Description

If applicable, this section should have a brief description of the technology the module integrates with and what that integration enables. This section should answer the questions: "What does this module *do*?" and "Why would I use it?"
    
If your module has a range of functionality (installation, configuration, management, etc.) this is the time to mention it.

##Setup

###What [Modulename] affects

* A list of files, packages, services, or operations that the module will alter, impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form. 

###Setup Requirements **OPTIONAL**

This module requires the following programs

puppet >= 3.3.0


Install the following puppet modules

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


	
###Beginning with [Modulename]	

The very basic steps needed for a user to get the module up and running. 

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

##Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

##Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

##Limitations

Designed and tested for Ubuntu 12.04
Should work on Ubuntu 14.04
May work on Debian 7
Will not work on CentOS / RHEL


##Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

##Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header. 