##Changelog

2014-March-24: 1.8.0  
 
- Adds support for 6-7-stable 
- Moves ldap_base to different line in gitlab config file   
- Changes placedog to placepuppy because the former was shutdown  
- Removes 'default server' in nginx config when running without ssl (port 80), fixes nginx -t warning. 
- Changes Text under sign in page layout in gitlab config to work with new markdown rendering engine in 6-7  
- Adds hostname as alias to nginx config



2014-Feb-26: 1.7.0

- Adds cron job to backup gitlab at 2 am every night 
see https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/backup_restore.md
- Exposes 2 new backup flags
- Installs and configures logrotate by default
- Unicorn should now use the proper number of cores for sidekick jobs


2014-Feb-24: 1.6.0

- Fixes outdated installation of nginx. 
- Adds nginx ppa and ensures latest version is installed. Should fix scalability issues and slow web interface problem
- Changes git version from 'present' to 'latest'

2014-Feb-24: 1.5.6  

- *Not released to puppet forge due to version 1.6.0 being released at same time*  
- Adds support for gitlab 6-6
- Inverts Changelog.md to have newest changes at top of file
- Fixes minor corrections to docs

2014-Feb-4: 1.5.5  

- Adds support for choosing your own ssh port (Thanks jasperla)
- Fixes missing documentation for user_changename (Thanks jasperla)

2014-Jan-24: 1.5.4 
 
- Improves ruby update-alternatives so puppet doesn't reapply every itteration
 (Thanks b4ldr)  
- Increases unicorn timeout from 30 to 60 to address issues with large repos  
- Increases gitlab config max_size from 5MB to 50MB to address issues with large repos  
- Adds support for 6.5  
- Updates module upgrade steps with improved instructions

2014-Jan-8: 1.5.3  

- Removes unessesary notifies (thanks daniel lawrence)  

2013-Dec-30: 1.5.1

- Fixes typos in readme file

2013-Dec-30: 1.5.0  

- Adds support for gitlab 6-4-stable
- $project_public_default was replaced with $visibility_level. Instead of public/private, projects can now be public/internal/private as of gitlab 6-4, $visibility_level lets you choose which of these 3 options to be the default

2013-Dec-19: 1.4.0  

- Adds Support for gitlabshell 1.8.0 (See step 3 https://github.com/gitlabhq/gitlabhq/blob/master/doc/update/6.2-to-6.3.md)
- Moves Changelog to it's own file

2013-Dec-9: 1.3.0 

- Replaced "package ensure=> present" with ensure_packages() from stdlib to prevent errors if package already exists.  

2013-Nov-22: 1.2.0 

- Fixes bug where gitlab-shell would reset to the master branch, Adds support for 6-3-stable  

2013-Nov-20: 1.1.3 

- Includes work around for issue where project would always be made public https://github.com/gitlabhq/gitlabhq/issues/5462 

2013-Nov-14: 1.1.2 

- Increases default gitlabshell from 1.7.4 to 1.7.8, as a result of a security vulnerability  

2013-Nov-11: 1.1.1 

- Increases default gitlabshell from 1.7.1 to 1.7.4, default branch is now 6-2-stable  

2013-Nov-1: 1.1.0 

- Adds new flag $default_servername, allows user to choose what subdomain gitlab is configured as in nginx
Instead of gitlab.foo.com, user can now make the url git.foo.com or any other subdomain  

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

2013-Oct-18: 0.3.1 

- Fixes issue where the thumbnail icon would be overwritten https://github.com/spuder/puppet-gitlab/issues/14  

2013-Oct-10: 0.3.0 

- Adds HTTPS Support, Updates Readme with links  

2013-Oct-10: 0.2.5 

- Fixes thumbnail issue  

2013-Oct-9: 0.2.4 

- Fixes backup issue when replacing thumbnail icons https://github.com/spuder/puppet-gitlab/issues/8  

2013-Oct-9: 0.2.3 

- Changes puppetlabs-apt dependency from 1.3.0 to 1.0.0   

2013-Oct-7: 0.2.2 

- Fixes puppetlabs-mysql api change https://github.com/spuder/puppet-gitlab/issues/1  

2013-Oct-5: 0.2.1 

- Adds module dependencies   

2013-Oct-5: 0.2.0 

- Removes ruby repo from files, and instead downloads from web  

2013-Oct-3: 0.1.0 

- First Release 





 






  

 














