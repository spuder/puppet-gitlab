##Changelog
2013-Oct-3: 0.1.0 First Release 
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
2013-Dec-9: 1.3.0 Replaced "package ensure=> present" with ensure_packages() from stdlib to prevent errors if package already exists.  
2013-Dec-19: 1.4.0  
- Adds Support for gitlabshell 1.8.0 (See step 3 https://github.com/gitlabhq/gitlabhq/blob/master/doc/update/6.2-to-6.3.md)
- Moves Changelog to it's own file