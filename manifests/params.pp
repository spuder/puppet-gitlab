# == Class: gitlab
#
# init manifest for gitlab class
#
# === Parameters
#
#  See below for full documentation of parameters
#
# === Examples
#
# DO NOT CALL THIS CLASS DIRECTLY, it is inherited automatically by init.pp
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab::params {

  # Manage Packages
  $puppet_manage_config   = true  # Manages /etc/gitlab/gitlab.rb
  $puppet_manage_backups  = true  # Creates cron job to backup at 2am
  $puppet_manage_packages = true  # Manages openssl and postfix packages

  # Gitlab server settings
  $gitlab_branch         = undef   # Required: (e.g. '7.0.0') - Branch to download and install
  $gitlab_release        = 'basic' # 'basic' | 'enterprise' - (default: basic)
  $gitlab_download_link  = undef   # e.g. 'https://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb', Enterprise only

  $external_url          = undef # Required: (eg. 'http://gitlab.example.com') - Sets nginx listening address

  #
  # 1. GitLab app settings
  # ==========================
  $gitlab_email_from                   = undef # 'gitlab@example.com'
  $gitlab_default_projects_limit       = undef # How many projects a user can create (default: 10)
  $gitlab_default_can_create_group     = undef # Allow users to make own groups (default: true)
  $gitlab_username_changing_enabled    = undef # Allow users to change own username, not suggested if running ldap
  $gitlab_default_theme                = undef # Color Theme - 1=Basic, 2=Mars, 3=Modern, 4=Gray, 5=Color (default: 2)
  $gitlab_signup_enabled               = undef # Anyone can create an account (default: true)
  $gitlab_signin_enabled               = undef # Sign in with shortname, eg. 'steve' vs 'steve@apple.com' (default: true)
  $gitlab_ssh_host                     = undef # which hostname should be used for creating ssh URLs. uses the fqdn by default
  $gitlab_restricted_visibility_levels = undef # which visibility levels are not available to non-admin users (default: none)

  $gitlab_default_projects_features_issues           = undef # Enables light weight issue tracker on projects (default: true)
  $gitlab_default_projects_features_merge_requests   = undef # Enables merge requests on projects (default: true)
  $gitlab_default_projects_features_wiki             = undef # Enables light weight wiki on projects (default: true)
  $gitlab_default_projects_features_snippets         = undef # Like github 'gits' (default: true)
  $gitlab_default_projects_features_visibility_level = undef # Project visibility ['public' | 'internal' | 'private'] (default: 'private')

  $issues_tracker_redmine               = undef # Integrate with redmine issue tracker (default: false)
  $issues_tracker_redmine_title         = undef # 'title'
  $issues_tracker_redmine_project_url   = undef # 'http://foo/bar'
  $issues_tracker_redmine_issues_url    = undef # 'http://foo/bar'
  $issues_tracker_redmine_new_issue_url = undef # 'http://foo/bar'

  $issues_tracker_jira               = undef # false, integrate with JIRA issue tracker
  $issues_tracker_jira_title         = undef # 'foo'
  $issues_tracker_jira_project_url   = undef # 'http://foo/bar'
  $issues_tracker_jira_issues_url    = undef # 'http://foo/bar'
  $issues_tracker_jira_new_issue_url = undef # 'http://foo/bar'

  $gravatar_enabled    = undef # Use user avatar image from Gravatar.com (default: true)
  $gravatar_plain_url  = undef # default: http://www.gravatar.com/avatar/%{hash}?s=%{size}&d=identicon
  $gravatar_ssl_url    = undef # default: https://secure.gravatar.com/avatar/%{hash}?s=%{size}&d=identicon

  #
  # 2. Auth settings
  # ==========================
  # These settings are documented in more detail at
  # https://gitlab.com/gitlab-org/gitlab-ce/blob/master/config/gitlab.yml.example#L118
  $ldap_enabled   = false
  $ldap_servers   = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_host      = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_port      = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_uid       = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_method    = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_bind_dn   = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_password  = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_allow_username_or_email_login = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_base      = undef #Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G

  $ldap_sync_time = undef # Prevent clicks from taking long time, see http://bit.ly/1qxpWQr
  
  # GitLab Enterprise Edition only
  $ldap_group_base  = undef # Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G
  $ldap_user_filter = undef # Deprecated in 7.4: http://bit.ly/1vOlT5Q, see: http://bit.ly/1CXbx3G

  # GitLab Enterprise Edition only (Requires 7.1.0 or greater)
  $ldap_sync_ssh_keys = undef # e.g. 'sshpublickey' - The object name in ldap where ssh keys are stored
  $ldap_admin_group   = undef # e.g. 'GitLab administrators' - The object name in ldap that matches administrator

  $omniauth_enabled                  = undef # Allows login via Google, twitter, Github ect..
  $omniauth_allow_single_sign_on     = false # CAUTION: Lets anyone with twitter/github/google account to authenticate. http://bit.ly/Uimqh9
  $omniauth_block_auto_created_users = true  # Lockdown new omniauth accounts until they are approved
  $omniauth_providers                = undef # See 'tests/omniauth.pp' for examples

  #
  # 3. Advanced settings
  # ==========================
  $satellites_path             = undef # /var/opt/gitlab/git-data/gitlab-satellites
  $satellites_timeout          = undef # Increase if merge requests timeout (seconds=> default: 30)

  $backup_path                 = undef # '/var/opt/gitlab/backups'   # Relative paths are relative to Rails.root (default: tmp/backups/)
  $backup_keep_time            = undef # default: 0 (forever) (in seconds), 604800 = 1 week
  
  $backup_upload_connection    = undef # Backup to fog http://bit.ly/1t5nAv5
  $backup_upload_remote_directory = undef # Where to store backups in fog http://bit.ly/1t5nAv5
  $gitlab_shell_path           = undef # '/opt/gitlab/embedded/service/gitlab-shell/'
  
  $gitlab_shell_repos_path     = undef # '/var/opt/gitlab/git-data/repositories', Cannot be a symlink
  $gitlab_shell_hooks_path     = undef # '/opt/gitlab/embedded/service/gitlab-shell/hooks/', Cannot be a symlikn
  
  $gitlab_shell_upload_pack    = undef # (default: true)
  $gitlab_shell_receive_pack   = undef # (default: true)
  
  $gitlab_shell_ssh_port       = undef # (default: 22)
  
  $git_bin_path                = undef # '/opt/gitlab/embedded/bin/git'
  $git_max_size                = undef # Incrase if large commits fail over https (default: 5242880) 5242880=5MB
  $git_timeout                 = undef # 10

  #
  # 4. Extra customization
  # ==========================
  $extra_google_analytics_id = undef
  
  $extra_piwik_url           = undef
  $extra_piwik_site_id       = undef
  
  $extra_sign_in_text        = undef # Allows for company logo/name on login page. See 'tests/sign_in_text.pp' for an example
  
  #
  # 5. Omnibus customization
  # ==========================
  $redis_port       = undef # (default: 6379)
  $postgresql_port  = undef # (default: 5432)
  $unicorn_port     = undef # (default: 8080)

  $git_data_dir     = undef # '/var/opt/gitlab/git-data'
  $gitlab_username  = undef # (default: 'gitlab')
  $gitlab_group     = undef # (default: 'gitlab')

  $redirect_http_to_https   = undef # Recommended to prevent users from connecting insecurely (default: false)
  $ssl_certificate          = undef
  $ssl_certificate_key      = undef
  $listen_addresses         = undef # Array of ip4v and ipv6 address nginx listens on  (e.g.  ["0.0.0.0","[::]"]  )

  $git_username       = undef # (default: git)
  $git_groupname      = undef # (default: git)
  $git_uid            = undef
  $git_gid            = undef
  $gitlab_redis_uid   = undef
  $gitlab_redis_gid   = undef
  $gitlab_psql_uid    = undef
  $gitlab_psql_gid    = undef

  $aws_enable               = false  # Store images on amazon
  $aws_access_key_id        = undef  # eg. 'AKIA1111111111111UA'
  $aws_secret_access_key    = undef  # eg. 'secret'
  $aws_bucket               = undef  # eg. 'my_gitlab_bucket'
  $aws_region               = undef  # eg. 'us-east-1'

  $smtp_enable               = false # Connect to external smtp server
  $smtp_address              = undef # 'smtp.server'
  $smtp_port                 = undef # default: 456
  $smtp_user_name            = undef # 'smtp user'
  $smtp_password             = undef # 'smtp password'
  $smtp_domain               = undef # 'example.com'
  $smtp_authentication       = undef # 'login'
  $smtp_enable_starttls_auto = true

  # Below are the default values
  $svlogd_size      = 200 * 1024 * 1024 # rotate after 200 MB of log data
  $svlogd_num       = 30 # keep 30 rotated log files
  $svlogd_timeout   = 24 * 60 * 60 # rotate after 24 hours
  $svlogd_filter    = 'gzip' # compress logs with gzip
  $svlogd_udp       = undef # transmit log messages via UDP
  $svlogd_prefix    = undef # custom prefix for log messages

  # Enterprise Only Features
  $udp_log_shipping_host = undef # e.g. '192.0.2.0' Ip of syslog server
  $udp_log_shipping_port = undef # syslog port (default: 514) 

  $high_availability_mountpoint = undef # Prevents omnibus-gitlab services (nginx, redis, unicorn etc.) from starting before a given filesystem is mounted

}
