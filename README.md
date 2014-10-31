# Gitlab 
[![Puppet Forge](http://img.shields.io/puppetforge/v/spuder/gitlab.svg)](https://forge.puppetlabs.com/spuder/gitlab) [![Build Status](https://travis-ci.org/spuder/puppet-gitlab.png)](https://travis-ci.org/spuder/puppet-gitlab) [![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/spuder/puppet-gitlab?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Source - [https://github.com/spuder/puppet-gitlab](https://github.com/spuder/puppet-gitlab)  
Forge  - [https://forge.puppetlabs.com/spuder/gitlab](https://forge.puppetlabs.com/spuder/gitlab)   
Changelog - [https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md](https://github.com/spuder/puppet-gitlab/blob/master/CHANGELOG.md) 



##Overview

Installs Gitlab 7 using the [omnibus installer](https://about.gitlab.com/downloads/)

**Version 2.x.x is a complete rewrite with many api breaking changes. 
Since it uses the omnibus installer, it is incompatible with the previous (<=1.x.x) puppet module.**

If upgrading from Gitlab 6.x, it is recommended that you create a fresh install and [migrate the data.](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md)



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
    $ sudo puppet apply -e "class { gitlab : gitlab_branch => '7.3.0', external_url => 'http://192.168.33.10', }" --debug

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

**There are over [100 configuration options](https://github.com/gitlabhq/gitlabhq/blob/master/config/gitlab.yml.example) in /etc/gitlab/gitlab.rb. This puppet module exposes nearly all of them as class parameters.**

### Mandatory parameters: 

    gitlab_branch 
    external_url

 All other parameters are optional. They are documented in the [init.pp](https://github.com/spuder/puppet-gitlab/blob/master/manifests/init.pp) and [params.pp](https://github.com/spuder/puppet-gitlab/blob/master/manifests/params.pp) files




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
  external_url           => 'https://gitlab.example.com',
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
    ldap_sync_time                    => 3600,
}
```

Ldap with Active Directory (Gitlab >=7.4)
```
# Gitlab 7.4 introduced a new ldap_servers parameter
# It combines all ldap settings into one json string, and also supports multiple ldap servers. 
# Both the old and syntax will continue to work. If using both simultainously, gitlab will prefer the older syntax. 
# See tests/active_directory.pp for more information
class { 'gitlab' : 
    puppet_manage_config              => true,
    puppet_manage_backups             => true,
    puppet_manage_packages            => true,
    gitlab_branch                     => '7.4.0',
    external_url                      => 'http://gitlab.example.com',
    ldap_enabled                      => true, 
    ldap_servers   => ['
{
  "primary" => {
    "label" => "LDAP",
    "host" => "hostname of LDAP server",
    "port" => 389,
    "uid" => "sAMAccountName",
    "method" => "plain",
    "bind_dn" => "CN=query user,CN=Users,DC=mycorp,DC=com",
    "password" => "query user password",
    "active_directory" => true,
    "allow_username_or_email_login" => true,
    "base" => "DC=mycorp,DC=com",
    "group_base" => "OU=groups,DC=mycorp,DC=com",
    "admin_group" => "",
    "sync_ssh_keys" => false,
    "sync_time" => 3600
  }
}',
',',
'{
  "secondary" => {
    "label" => "LDAP",
    "host" => "hostname of LDAP server",
    "port" => 389,
    "uid" => "sAMAccountName",
    "method" => "plain",
    "bind_dn" => "CN=query user,CN=Users,DC=mycorp,DC=com",
    "password" => "query user password",
    "active_directory" => true,
    "allow_username_or_email_login" => true,
    "base" => "DC=mycorp,DC=com",
    "group_base" => "OU=groups,DC=mycorp,DC=com",
    "admin_group" => "",
    "sync_ssh_keys" => false,
    "sync_time" => 3600
  }
}'],

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

The parameters above are typically placed inside a wrapper puppet module, or inside the nodes.pp file. [(Additional information)](http://garylarizza.com/blog/2014/02/17/puppet-workflow-part-2/)

You can alternativly put the parameters inside hiera. This has the advantage of keeping your wrapper puppet module (or nodes.pp file) clean, and also keeps things like passwords outside of version control. 

gitlab.example.com.yaml
```
---
  gitlab::puppet_manage_config:   true
  gitlab::puppet_manage_backups:  true
  gitlab::puppet_manage_packages: true
  gitlab::gitlab_branch: 7.2.0
  gitlab::gitlab_release: basic
  gitlab::external_url: gitlab.example.com
  gitlab::ldap_enabled: true
  gitlab::ldap_password: correct-horse-battery-staple
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
*Note: If manually managing the gitlab.rb file, you will likely also need to start the service manually with `gitlab-ctl start`*

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
2. Change the `gitlab_branch` parameter to the new version (e.g. 7.1.0 -> 7.2.0)
3. Wait for next puppet run

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

## Parameters Continued


```
# === Parameters
#
# [*puppet_manage_config*]
#   default => true
#   /etc/gitlab/gitlab.rb will be managed by puppet
# 
# [*puppet_manage_backups*]
#   default => true
#   Includes backup.pp which sets cron job to run rake task
# 
# [*puppet_manage_packages*]
#   default => true
#   Includes packages.pp which installs postfix and openssh
#   Gitlab packages will be managed regardless if this parameter is true or false
#
# [*external_url*]
#   default => undef
#   Required parameter, specifies the url that end user will navigate to
#   Example: 'https://gitlab.example.com'
#
# [*gitlab_branch*]
#   default => undef
#   Required parameter, specifies which gitlab branch to download and install
#   Example: '7.0.0'
#
# [*gitlab_release*]
#    default => 'basic'
#    specifies 'basic' or 'enterprise' version to download, some parameters are disabled if basid
#    Example: 'enterprise'
#
# [*gitlab_download_link*]
#    default => undef 
#    specifies url to download gitlab from, optional if gitlab_release = basic
#    Example: 'https://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb'
#
# [*external_url*]
#    default => undef
#    Required paramter, the url configured in nginx
#    Example: 'http://gitlab.example.com'
#
# 1. Gitlab app settings
# ======================
#
# [*gitlab_email_from*]
#    default => undef
#    Example: 'gitlab@example.com' 
#
# [*gitlab_default_projects_limit*]
#    default => undef
#    How many projects a user can create
#    Example: 42
#
# [*gitlab_default_can_create_group*]
#    default => undef
#    Allow users to make own groups, (gitlab default: true)
#    Example: false
#
# [*gitlab_username_changing_enabled*]
#    default => undef
#    Allow users to change own username, not suggested if running ldap
#    Example: false
#
# [*gitlab_default_theme*]
#    default => undef
#    Color Theme:  1=Basic, 2=Mars, 3=Modern, 4=Gray, 5=Color (gitlab default: 2)
#    Example: 3
#
# [*gitlab_signup_enabled*]
#    default => undef
#    Anyone can create an account (gitlab default: true)
#    Example: false
#
# [*gitlab_signin_enabled*]
#    default => undef
#    Sign in with shortname, eg. 'steve' vs 'steve@apple.com' (gitlab default: true)
#    Example: false
#
# [*gitlab_ssh_host*]
#    default => undef
#    Example: 'gitlab.example.com'
#
# [*gitlab_restricted_visibility_levels*]
#    default => undef
#    Array of visibility levels that are not available to non-admin users (gitlab default: none)
#    Example: ['public', 'internal']
#
# [*gitlab_default_projects_features_issues*]
#    default => undef
#    Enables light weight issue tracker on projects (gitlab default: true)
#    Example: false
#
# [*gitlab_default_projects_features_merge_requests*]
#    default => undef
#    Enables merge requests on projects (gitlab default: true)
#    Example: false
#
# [*gitlab_default_projects_features_wiki*]
#    default => undef
#    Enables light weight wiki on projects (gitlab default: true)
#    Example: false
#
# [*gitlab_default_projects_features_snippets*]
#    default => undef
#    Like github 'gits' (default: true)
#    Example: false
#
# [*gitlab_default_projects_features_visibility_level*]
#    default => undef
#    Project visibility ['public' | 'internal' | 'private'] (gitlab default: 'private')
#    Example: false
#
# [*issues_tracker_redmine*]
#    default => undef
#    Integrate with redmine issue tracker (gitlab default: false)
#    Example: false
#
# [*issues_tracker_redmine_title*]
#    default => undef
#    Example: 'title'
#
# [*issues_tracker_redmine_project_url*]
#    default => undef
#    Example: 'http://foo.example.com'
#
# [*issues_tracker_redmine_issues_url*]
#    default => undef
#    Example: 'http://foo.example.com'
#
# [*issues_tracker_redmine_new_issue_url*]
#    default => undef
#    Example: 'http://foo.example.com'
#
# [*issues_tracker_jira*]
#    default => undef
#    Example: false
#
# [*issues_tracker_jira_title*]
#    default => undef
#    Example: 'foo'
#
# [*issues_tracker_jira_project_url*]
#    default => undef
#    Example: 'http://foo.example.com'
#
# [*issues_tracker_jira_project_url*]
#    default => undef
#    Example: 'http://foo.example.com'
#
# [*issues_tracker_jira_new_issue_url*]
#    default => undef
#    Example: 'http://foo.example.com'
#
# [*gravatar_enabled*]
#    default => undef
#    Use user avatar image from Gravatar.com (gitlab default: true)
#    Example: true
#
# [*gravatar_plain_url*]
#    default => undef
#    Example: 'http://www.gravatar.com/avatar/%{hash}?s=%{size}&d=identicon'
#
# [*gravatar_ssl_url*]
#    default => undef
#    Example: 'https://secure.gravatar.com/avatar/%{hash}?s=%{size}&d=identicon'
#
# 2. Auth settings
# ==========================
#
# [*ldap_enabled*]
#    default => false
#
# [*ldap_servers*]
#   default => undef
#   Introduced in Gitlab 7.4, see tests/active_directory.pp for more info
#
# [*ldap_host*]
#    default => 'server.example.com'
#    See tests/active_directory.pp for more info
#    
# [*ldap_port*]
#     default => 636
#     Example: 389
#    See tests/active_directory.pp for more info
#    
# [*ldap_uid*]
#     default => 'sAMAccountName'
#     Example: 'uid'
#    See tests/active_directory.pp for more info
#
# [*ldap_method*]
#     default => 'ssl'
#     Example: 'ssl'
#    See tests/active_directory.pp for more info
# 
# [*ldap_bind_dn*]
#     default => 'CN=query user,CN=Users,DC=mycorp,DC=com'
#    See tests/active_directory.pp for more info
#
# [*ldap_password*]
#     default => 'correct-horse-battery-staple'
#    See tests/active_directory.pp for more info
#
# [*ldap_allow_username_or_email_login*]
#     default => true
#     See tests/active_directory.pp for more info
#
# [*ldap_base*]
#     default => DC=mycorp,DC=com
#     See tests/active_directory.pp for more info
#
# [*ldap_sync_time*]
#     default => undef
#     Prevent clicks from taking long time, see http://bit.ly/1qxpWQr
#     See tests/active_directory.pp for more info
#
# [*ldap_group_base*]
#     default => ''
#     Enterprise only feature, Ldap groups map to gitlab groups
#     See tests/active_directory.pp for more info
#     Example: 'OU=groups,DC=mycorp,DC=com'
#
# [*ldap_user_filter*]
#     default => ''
#     Enterprise only feature, filter ldap group
#     Example: '(memberOf=CN=my department,OU=groups,DC=mycorp,DC=com)'
#     See tests/active_directory.pp for more info
#
# [*ldap_sync_ssh_keys*]
#     default => undef
#     Enterprise only feature, The bject name in ldap where ssh keys are stored
#     Example: 'sshpublickey'
#     See tests/active_directory.pp for more info
#
# [*ldap_admin_group*]
#     default => undef
#     Enterprise only feature, The object name in ldap that matches administrators
#     Example: 'GitLab administrators'
#     See tests/active_directory.pp for more info
#
# [*omniauth_enabled*]
#     default => undef
#     Allows login via Google, twitter, Github ect..
#     Example: true
#
# [*omniauth_allow_single_sign_on*]
#     default => false
#     CAUTION: Lets anyone with twitter/github/google account to authenticate. http://bit.ly/Uimqh9
#     Example: 'sshpublickey'
#
# [*omniauth_block_auto_created_users*]
#     default => true
#     Lockdown new omniauth accounts until they are approved
#     Example: true
#
# [*omniauth_providers*]
#     default => undef
#     Allows user to authenticate with Twitter, Google, Github ect... 
#     Example: [ '{
#         "name"   => "google_oauth2",
#         "app_id" => "YOUR APP ID",
#         "app_secret" => "YOUR APP SECRET",
#         "args"   => { "access_type" => "offline", "approval_prompt" => "" }
#       }',
#       ',',
#       '{ 
#         "name"   => "twitter",
#         "app_id" => "YOUR APP ID",
#         "app_secret" =>  "YOUR APP SECRET"
#       }',
#       ',',
#       '{ "name"   => "github",
#         "app_id" => "YOUR APP ID",
#         "app_secret" =>  "YOUR APP SECRET",
#         "args"  => { "scope" =>  "user:email" }
#       }'
#     ],
#     See tests/ominiauth.pp for more information
#
# 3. Advanced settings
# ==========================
#
# [*satellites_path*]
#     default => undef
#     Where satellite scripts are run
#     Example: /var/opt/gitlab/git-data/gitlab-satellites
#
# [*satellites_timeout*]
#     default => undef
#     Increase if merge requests timeout (gitlab default: 30)
#     Example: 120
#
# [*backup_path*]
#     default => undef
#     Location for backups (relative to rails root) 
#     Example: '/var/opt/gitlab/backups'
#
# [*backup_keep_time*]
#     default => undef
#     Number of seconds to keep backups. gitlab default: 0 (forever)
#     Example: 604800     # 1 week
#
# [*backup_upload_connection*]
#    default => undef
#    Backup with fog, see http://bit.ly/1t5nAv5
#
# [*backup_upload_remote_directory*]
#    default => undef
#    Location to backup to in fog http://bit.ly/1t5nAv5
#
# [*gitlab_shell_path*]
#     default => undef
#     Where gitlab-shell is located
#     Example: /opt/gitlab/embedded/service/gitlab-shell/
#
# [*gitlab_shell_repos_path*]
#     default => undef
#     Path where gitlab shell repos are stored
#     Example: '/var/opt/gitlab/git-data/repositories' # Cannot be a symlink
#
# [*gitlab_shell_hooks_path*]
#     default => undef
#     Path for git hooks
#     Example: '/opt/gitlab/embedded/service/gitlab-shell/hooks/' # Cannot be a symlink
#
# [*gitlab_shell_upload_pack*]
#     default => undef
#     Run shell upload pack on git repos
#     Example: true
#
# [*gitlab_shell_receive_pack*]
#     default => undef
#     Run shell recieve pack on git repos
#     Example: true
#
# [*gitlab_shell_ssh_port*]
#     default => undef
#     Port ssh runs on
#     Example: 22
#
# [*git_bin_path*]
#     default => undef
#     Path to git repo, Make sure you know what you are doing
#     Example: '/opt/bin/gitlab/embedded/bin/git'
#
# [*git_max_size*]
#     default => undef
#     Maximum size of https packets. Increase if large commits fail. (git default 5242880 [5mb)
#     Example: 25600
#
# [*git_timeout*]
#     default => undef
#     Timeout (in seconds) for git shell
#     Example: 10
#
# 4. Extra customization
# ==========================
#
# [*extra_google_analytics_id*]
#     default => undef
#
# [*extra_piwik_url*]
#     default => undef
#
# [*extra_sign_in_text*]
#     default => undef
#     Allows for company logo/name on login page. See 'tests/sign_in_text.pp' for an example
#
# 5. Omnibus customization
# ==========================
#
# [*redis_port*]
#     default => undef
#     Deprecated in 7.3: Port redis runs on
#     Example: 6379
#
# [*postgresql_port*]
#     default => undef
#     Port postgres runs on
#     Example: 5432
#
# [*unicorn_port*]
#     default => undef
#     Port unicorn runs on
#     Example: 8080
#
# [*git_data_dir*]
#     default => undef
#     Example: '/var/opt/gitlab/git-data'
#
# [*gitlab_username*]
#     default => undef
#     Local username
#     Example: 'gitlab'
#
# [*gitlab_group*]
#     default => undef
#     Local groupname
#     Example: 'gitlab'
#
# [*redirect_http_to_https*]
#     default => undef
#     Sets nginx 301 redirect from http to https urls. Requires ssl be enabled (gitlab default: false)
#     Example: true
#
# [*ssl_certificate*]
#     default => '/etc/gitlab/ssl/gitlab.crt'
#     Location of ssl certificate
#     Example: '/etc/gitlab/ssl/gitlab.crt'
#
# [*ssl_certificate_key*]
#     default => '/etc/gitlab/ssl/gitlab.key'
#     Location of ssl key
#     Example: '/etc/gitlab/ssl/gitlab.key'
#
# [*listen_address*]
#     default => undef
#     Array of ipv4 and ipv6 address nginx listens on
#     Example: ["0.0.0.0","[::]"]
#
# [*git_username*]
#     default => undef
#     name of git user users authenticate as. (default: 'git' ) Used as the ssh user name e.g git@gitlab.com
#     Example: 'git'
#
# [*git_groupname*]
#     default => undef
#     name of git group (default: 'git' ) 
#     Example: 42
#
# [*git_uid*]
#     default => undef
#     uid of git user, (the user gitlab-shell runs under)
#     Example: 42
#
# [*git_gid*]
#     default => undef
#     gid of git user, (the user gitlab-shell runs under)
#     Example: 42
#
# [*gitlab_redis_uid*]
#     default => undef
#     Example: 42
#
# [*gitlab_redis_gid*]
#     default => undef
#     Example: 42
#
# [*gitlab_psql_uid*]
#     default => undef
#     Example: 42
#
# [*gitlab_psql_gid*]
#     default => undef
#     Example: 42
#
# [*aws_enable*]
#     default => false
#     Store images on amazon
#     Example: true
#
# [*aws_access_key_id*]
#     default => undef
#     Example: 'AKIA1111111111111UA'
#
# [*aws_secret_access_key*]
#     default => undef
#     Example: 'secret'
#
# [*aws_bucket*]
#     default => undef
#     Example: 'my_gitlab_bucket'
#
# [*aws_region*]
#     default => undef
#     Example: 'us-east-1'
#
# [*smtp_enable*]
#     default => false
#     Connect to external smtp server
#     Example: true
#
# [*smtp_address*]
#     default => undef
#     smtp server hostname
#     Example: 'smtp.example.com'
#
# [*smtp_port*]
#     default => undef
#     Example: 456
#
# [*smtp_user_name*]
#     default => undef
#     Example: 'smtp user'
#
# [*smtp_password*]
#     default => undef
#     Example: 'correct-horse-battery-staple'
#
# [*smtp_domain*]
#     default => undef
#     Example: 'example.com'
#
# [*smtp_authentication*]
#     default => undef
#     How smtp authorizes
#     Example: 'login'
#
# [*smtp_enable_starttls_auto*]
#     default => true
#     Use tls on smtp server
#     Example: true
#
# [*svlogd_size*]
#     default => 200 * 1024 * 1024
#     Rotate after x number of bytes
#     Example: 200 * 1024 * 1024 # 200MB
#
# [*svlogd_num*]
#     default => 30
#     Number of rotated logs to keep
#     Example: 60
#
# [*svlogd_timeout*]
#     default => 24 * 60 * 60
#     How long between log rotations (minutes)
#     Example: 24 * 60 * 60 # 24hours
#
# [*svlogd_filter*]
#     default => 'gzip'
#     Compress logs
#
# [*svlogd_udp*]
#     default => undef
#     Transmit logs via UDP
#     Example: #TODO: find example
#
# [*svlogd_prefix*]
#     default => undef
#     Custom prefix for log messages
#     Example: #TODO: find example
#
# [*udp_log_shipping_host*]
#     default => undef
#     Enterprise Edition Only - ip of syslog server
#     Example: '192.0.2.0'
#
# [*udp_log_shipping_port*]
#     default => undef
#     Enterprise Edition Only - port of syslog server
#     Example: 514
#
# [*high_availability_mountpoint*]
#     default => undef
#     Prevents omnibus-gitlab services (nginx, redis, unicorn etc.) from starting before a given filesystem is mounted
#     Example: '/tmp'
#
```
