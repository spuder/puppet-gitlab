# == Class: gitlab
#
# init manifest for gitlab class
#
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
#    string must end in '.deb' or '.rpm'
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
# === Examples
#
# Basic Example with https
# class { 'gitlab' : 
#   gitlab_branch          => '7.0.0',
#   external_url           => 'http://foo.bar',
#   ssl_certificate        => '/etc/gitlab/ssl/gitlab.crt',
#   ssl_certificate_key    => '/etc/gitlab/ssl/gitlab.key',
#   redirect_http_to_https => true,
#   puppet_manage_backups  => true,
#   backup_keep_time       => 5184000, # In seconds, 5184000 = 60 days
#   gitlab_default_projects_limit => 100,
# }
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab (

  $puppet_manage_config    = $::gitlab::params::puppet_manage_config,
  $puppet_manage_backups   = $::gitlab::params::puppet_manage_backups,
  $puppet_manage_packages  = $::gitlab::params::puppet_manage_packages,


  $gitlab_branch           = $::gitlab::params::gitlab_branch,
  $gitlab_release          = $::gitlab::params::gitlab_release,
  $gitlab_download_link    = $::gitlab::params::gitlab_download_link,

  $external_url   = $::gitlab::params::external_url,

  #
  # 1. GitLab app settings
  # ==========================

  $gitlab_email_from                   = $::gitlab::params::gitlab_email_from,
  $gitlab_default_projects_limit       = $::gitlab::params::gitlab_default_projects_limit,
  $gitlab_default_can_create_group     = $::gitlab::params::gitlab_default_can_create_group,
  $gitlab_username_changing_enabled    = $::gitlab::params::gitlab_username_changing_enabled,
  $gitlab_default_theme                = $::gitlab::params::gitlab_default_theme,
  $gitlab_signup_enabled               = $::gitlab::params::gitlab_signup_enabled,
  $gitlab_signin_enabled               = $::gitlab::params::gitlab_signin_enabled,
  $gitlab_ssh_host                     = $::gitlab::params::gitlab_ssh_host,
  $gitlab_restricted_visibility_levels = $::gitlab::params::gitlab_restricted_visibility_levels,

  $gitlab_default_projects_features_issues           = $::gitlab::params::gitlab_default_projects_features_issues,
  $gitlab_default_projects_features_merge_requests   = $::gitlab::params::gitlab_default_projects_features_merge_requests,
  $gitlab_default_projects_features_wiki             = $::gitlab::params::gitlab_default_projects_features_wiki,
  $gitlab_default_projects_features_snippets         = $::gitlab::params::gitlab_default_projects_features_snippets,
  $gitlab_default_projects_features_visibility_level = $::gitlab::params::gitlab_default_projects_features_visibility_level,

  $issues_tracker_redmine               = $::gitlab::params::issues_tracker_redmine,
  $issues_tracker_redmine_title         = $::gitlab::params::issues_tracker_redmine_title,
  $issues_tracker_redmine_project_url   = $::gitlab::params::issues_tracker_redmine_project_url,
  $issues_tracker_redmine_issues_url    = $::gitlab::params::issues_tracker_redmine_issues_url,
  $issues_tracker_redmine_new_issue_url = $::gitlab::params::issues_tracker_redmine_new_issue_url,

  $issues_tracker_jira               = $::gitlab::params::issues_tracker_jira,
  $issues_tracker_jira_title         = $::gitlab::params::issues_tracker_jira_title,
  $issues_tracker_jira_project_url   = $::gitlab::params::issues_tracker_jira_project_url,
  $issues_tracker_jira_issues_url    = $::gitlab::params::issues_tracker_jira_issues_url,
  $issues_tracker_jira_new_issue_url = $::gitlab::params::issues_tracker_jira_new_issue_url,

  $gravatar_enabled    = $::gitlab::params::gravatar_enabled,
  $gravatar_plain_url  = $::gitlab::params::gravatar_plain_url,
  $gravatar_ssl_url    = $::gitlab::params::gravatar_ssl_url,

  #
  # 2. Auth settings
  # ==========================

  $ldap_enabled   = $::gitlab::params::ldap_enabled,
  $ldap_servers   = $::gitlab::params::ldap_servers,
  $ldap_host      = $::gitlab::params::ldap_host,
  $ldap_port      = $::gitlab::params::ldap_port,
  $ldap_uid       = $::gitlab::params::ldap_uid,
  $ldap_method    = $::gitlab::params::ldap_method,
  $ldap_bind_dn   = $::gitlab::params::ldap_bind_dn,
  $ldap_password  = $::gitlab::params::ldap_password,
  
  $ldap_sync_time = $::gitlab::params::ldap_sync_time,

  $ldap_allow_username_or_email_login = $::gitlab::params::ldap_allow_username_or_email_login,
  $ldap_base                          = $::gitlab::params::ldap_base,

  $ldap_group_base  = $::gitlab::params::ldap_group_base,
  $ldap_user_filter = $::gitlab::params::ldap_user_filter,

  $ldap_sync_ssh_keys = $::gitlab::params::ldap_sync_ssh_keys,
  $ldap_admin_group   = $::gitlab::params::ldap_admin_group,

  $omniauth_enabled                   = $::gitlab::params::omniauth_enabled,
  $omniauth_allow_single_sign_on      = $::gitlab::params::omniauth_allow_single_sign_on,
  $omniauth_block_auto_created_users  = $::gitlab::params::omniauth_block_auto_created_users,
  $omniauth_providers                 = $::gitlab::params::omniauth_providers,

  #
  # 3. Advanced settings
  # ==========================

  $satellites_path             = $::gitlab::params::satellites_path,
  $satellites_timeout          = $::gitlab::params::satellites_timeout,

  $backup_path                 = $::gitlab::params::backup_path,
  $backup_keep_time            = $::gitlab::params::backup_keep_time,
  $backup_upload_connection    = $::gitlab::params::backup_upload_connection,
  $backup_upload_remote_directory = $::gitlab::params::backup_upload_remote_directory,
  $gitlab_shell_path           = $::gitlab::params::gitlab_shell_path,
  $gitlab_shell_repos_path     = $::gitlab::params::gitlab_shell_repos_path,
  $gitlab_shell_hooks_path     = $::gitlab::params::gitlab_shell_hooks_path,
  $gitlab_shell_upload_pack    = $::gitlab::params::gitlab_shell_upload_pack,
  $gitlab_shell_receive_pack   = $::gitlab::params::gitlab_shell_receive_pack,
  $gitlab_shell_ssh_port       = $::gitlab::params::gitlab_shell_ssh_port,
  $git_bin_path                = $::gitlab::params::git_bin_path,
  $git_max_size                = $::gitlab::params::git_max_size,
  $git_timeout                 = $::gitlab::params::git_timeout,

  #
  # 4. Extra customization
  # ==========================

  $extra_google_analytics_id = $::gitlab::params::extra_google_analytics_id,
  $extra_piwik_url           = $::gitlab::params::extra_piwik_url,
  $extra_piwik_site_id       = $::gitlab::params::extra_piwik_site_id,
  $extra_sign_in_text        = $::gitlab::params::extra_sign_in_text,

  #
  # 5. Omnibus customization
  # ==========================

  $redis_port       = $::gitlab::params::redis_port,
  $postgresql_port  = $::gitlab::params::postgresql_port,
  $unicorn_port     = $::gitlab::params::unicorn_port,
  
  $git_data_dir     = $::gitlab::params::git_data_dir,
  $gitlab_username  = $::gitlab::params::gitlab_username,
  $gitlab_group     = $::gitlab::params::gitlab_group,
  
  $redirect_http_to_https   = $::gitlab::params::redirect_http_to_https,
  $ssl_certificate          = $::gitlab::params::ssl_certificate,
  $ssl_certificate_key      = $::gitlab::params::ssl_certificate_key,
  $listen_addresses         = $::gitlab::params::listen_addresses,
  
  $git_username       = $::gitlab::params::git_username,
  $git_groupname      = $::gitlab::params::git_groupname,
  $git_uid            = $::gitlab::params::git_uid,
  $git_gid            = $::gitlab::params::git_gid,
  $gitlab_redis_uid   = $::gitlab::params::gitlab_redis_uid,
  $gitlab_redis_gid   = $::gitlab::params::gitlab_redis_gid,
  $gitlab_psql_uid    = $::gitlab::params::gitlab_psql_uid,
  $gitlab_psql_gid    = $::gitlab::params::gitlab_psql_gid,
  
  $aws_enable               = $::gitlab::params::aws_enable,
  $aws_access_key_id        = $::gitlab::params::aws_access_key_id,
  $aws_secret_access_key    = $::gitlab::params::aws_secret_access_key,
  $aws_bucket               = $::gitlab::params::aws_bucket,
  $aws_region               = $::gitlab::params::aws_region,
  
  $smtp_enable               = $::gitlab::params::smtp_enable,
  $smtp_address              = $::gitlab::params::smtp_address,
  $smtp_port                 = $::gitlab::params::smtp_port,
  $smtp_user_name            = $::gitlab::params::smtp_user_name,
  $smtp_password             = $::gitlab::params::smtp_password,
  $smtp_domain               = $::gitlab::params::smtp_domain,
  $smtp_authentication       = $::gitlab::params::smtp_authentication,
  $smtp_enable_starttls_auto = $::gitlab::params::smtp_enable_starttls_auto,
  
  $svlogd_size      = $::gitlab::params::svlogd_size,
  $svlogd_num       = $::gitlab::params::svlogd_num,
  $svlogd_timeout   = $::gitlab::params::svlogd_timeout,
  $svlogd_filter    = $::gitlab::params::svlogd_filter,
  $svlogd_udp       = $::gitlab::params::svlogd_udp,
  $svlogd_prefix    = $::gitlab::params::svlogd_prefix,

  $udp_log_shipping_host = $::gitlab::params::udp_log_shipping_host,
  $udp_log_shipping_port = $::gitlab::params::udp_log_shipping_port,

  $high_availability_mountpoint = $::gitlab::params::high_availability_mountpoint,

  ) inherits gitlab::params {

  # Verify required parameters are provided. 
  if !$external_url {
    fail ("\$external_url parameter required. \
    https://github.com/spuder/puppet-gitlab/blob/master/README.md")
  }
  if !$gitlab_branch {
    fail ("\$gitlab_branch parameter required. \
    https://github.com/spuder/puppet-gitlab/blob/master/README.md")
  }

  if versioncmp($::puppetversion, '3.0.0') < 0 {
    fail("Gitlab requires puppet 3.0.0 or greater, found: \'${::puppetversion}\'")
  }

  # Verify prameters are valid for the version of gitlab
  if versioncmp($gitlab_branch, '7.1.0') < 0 {
    if $ldap_sync_ssh_keys {
      fail("\$ldap_sync_ssh_keys is only available in gitlab 7.1.0 or greater, found: \'${gitlab_branch}\'")
    }
    if $ldap_admin_group {
      fail("\$ldap_admin_group is only available in gitlab 7.1.0 or greater, found: \'${gitlab_branch}\'")
    }
  }

  # Verify parameters are valid for the release of gitlab
  if $gitlab_release != 'enterprise' {
    if $ldap_sync_ssh_keys {
      fail("\$ldap_sync_ssh_keys is only available in enterprise edtition, gitlab_release is: \'${gitlab_release}\'")
    }
    if $ldap_admin_group {
      fail("\$ldap_admin_group is only available in enterprise edtition, gitlab_release is: \'${gitlab_release}\'")
    }
  }

  # Verify external_url includes http:// or https://
  if $external_url {
    validate_re($external_url, 'http(s)?://', 'external_url must contain string http:// or https://')
  }

  # Gitlab only supplies omnibus downloads for few select operating systems.
  # Warn the user they may be using an unsupported OS
  # https://about.gitlab.com/downloads/
  case $::operatingsystemrelease {
    '12.04': {}
    '14.04': {}
    '7.6':   {}
    '6.5':   {}
    '7.0':   {}
    default: { warning("\'${::operatingsystem}\' \'${::operatingsystemrelease}\' is not on approved list,\
      download may fail. See https://about.gitlab.com/downloads/ for supported OS's")
    }
  }

  # Set the order that the manifests are executed in
  if $puppet_manage_config  == true {
    notice('Puppet will manage the configuration file because $puppet_manage_config is true')
    include ::gitlab::install
    include ::gitlab::config
    Class['::gitlab::install'] -> Class['::gitlab::config']
  }
  else {
    info('Puppet is not managing /opt/gitlab/gitlab.rb because $puppet_manage_config is false')
  }

  if $puppet_manage_packages == true {
    notice('Puppet will manage packages because $puppet_manage_packages is true')
    include ::gitlab::install
    include ::gitlab::packages
    Class['::gitlab::packages'] -> Class['::gitlab::install']
  }
  else {
    warning('$puppet_manage_packages is false, assuming postfix and openssl are already present ')
  }

  if $puppet_manage_backups == true {
    notice('Puppet will manage backups because $puppet_manage_backups is true')
    include ::gitlab::install
    include ::gitlab::backup
    Class['::gitlab::install'] -> Class['::gitlab::backup']
  }
  else {
    warning('Puppet is not creating gitlab backups, recommend setting $puppet_manage_backups => true')
  }

  # Ensure high_availability_mountpoint is only used with gitlab > 7.2.x
  if $high_availability_mountpoint {
    if versioncmp( $gitlab_branch, '7.2.0') < 0 {
      fail("high_availability_mountpoint is only available in gitlab >= 7.2.0, found \'${gitlab_branch}\'")
    }
  }

  # Ensure gitlab_ssh_host is only used with gitlab > 7.2.x
  if $gitlab_ssh_host {
    if versioncmp( $gitlab_branch, '7.2.0') < 0 {
      fail("gitlab_ssh_host is only available in gitlab >= 7.2.0, found \'${gitlab_branch}\'")
    }
  }

  # Ensure listen_addresses is only used with gitlab > 7.2.x
  if $listen_addresses {
    if versioncmp( $gitlab_branch, '7.2.0') < 0 {
      fail("listen_addresses is only available in gitlab >= 7.2.0, found \'${gitlab_branch}\'")
    }
  }

  # Ensure ldap_sync_time is only used with gitlab > 7.2.x
  if $ldap_sync_time {
    if versioncmp( $gitlab_branch, '7.2.0') < 0 {
      fail("ldap_sync_time is only available in gitlab >= 7.2.0, found \'${gitlab_branch}\'")
    }
  }

  # Warn if redis_port is defined, and using gitlab > 7.3
  if $redis_port {
    if versioncmp( $gitlab_branch, '7.3.0') >= 0 {
      warning('redis_port has been deprecated in gitlab 7.3, please remove. http://bit.ly/1DEI9m2')
    }
  }

  # Fail if attempting to use ldap_servers on old versions of gitlab, or on non enterprise editions
  if $ldap_servers {
    if versioncmp( $gitlab_branch, '7.4.0') < 0 {
      fail("ldap_servers is only available in gitlab >= 7.4.0, found \'${gitlab_branch}\'")
    }
  }

  # Fail if attempting to use ldap parameters with gitlab 7.4
  # https://about.gitlab.com/2014/10/22/gitlab-7-4-released/
  # https://gitlab.com/gitlab-org/gitlab-ce/blob/a0a826ebdcb783c660dd40d8cb217db28a9d4998/config/gitlab.yml.example
  if versioncmp( $gitlab_branch, '7.4.0') >=0 {
    if $ldap_host or $ldap_port or $ldap_uid or $ldap_method or $ldap_bind_dn or $ldap_password or $ldap_allow_username_or_email_login or $ldap_base or $ldap_group_base or $ldap_user_filter{
      notice('Gitlab 7.4 introduced new syntax for ldap configurations, https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/integration/ldap.md, http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G')
    }
  }


  # If all 3 $puppet_manage_* parameters are false, then just install gitlab
  include ::gitlab::install

}# end gitlab

