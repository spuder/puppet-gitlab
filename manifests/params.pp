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
  $puppet_manage_config  = undef  # Manages /etc/gitlab/gitlab.rb
  $puppet_manage_backups = true   # Creates cron job to backup at 2am

  # Gitlab server settings
  $gitlab_branch         = undef   # Required: (e.g. '7.0.0') - Branch to download and install
  $gitlab_release        = 'basic' # 'basic' | 'enterprise' - (default: basic)
  $gitlab_download_link  = undef   # e.g. 'https://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb', Enterprise only

  $external_url            = undef # Required: (eg. 'http://gitlab.example.com') - Sets nginx listening address

#
# 1. GitLab app settings
# ==========================
  $gitlab_email_from                 = undef # 'gitlab.example.com'
  $gitlab_default_projects_limit     = undef # How many projects a user can create (default: 10)
  $gitlab_default_can_create_group   = undef # Allow users to make own groups (default: true)
  $gitlab_username_changing_enabled  = undef # Allow users to change own username, not suggested if running ldap
  $gitlab_default_theme              = undef # Color Theme - 1=Basic, 2=Mars, 3=Modern, 4=Gray, 5=Color (default: 2)
  $gitlab_signup_enabled             = undef # Anyone can create an account (default: true)
  $gitlab_signin_enabled             = undef # Sign in with hortname, eg. 'steve' vs 'steve@apple.com' (default: true)

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
  $ldap_host      = 'hostname of LDAP server'
  $ldap_port      = 389 # or 636
  $ldap_uid       = 'sAMAccountName' # or 'uid'
  $ldap_method    = 'plain' # 'ssl' or 'plain'
  $ldap_bind_dn   = 'CN=query user,CN=Users,DC=mycorp,DC=com'
  $ldap_password  = 'query user password'
  $ldap_allow_username_or_email_login = true
  $ldap_base      = 'DC=mycorp,DC=com'

  # GitLab Enterprise Edition only
  # Set $gitlab_release to 'enterprise' to enable these features
  $ldap_group_base  = '' # Example: 'OU=groups,DC=mycorp,DC=com'
  $ldap_user_filter = '' # Example: '(memberOf=CN=my department,OU=groups,DC=mycorp,DC=com)'

  $omniauth_enabled                  = undef # Allows login via Google, twitter, Github ect..
  $omniauth_allow_single_sign_on     = undef #TODO: Implement in erb template
  $omniauth_block_auto_created_users = undef #TODO: Implement in erb template
  $omniauth_providers                = '[]'  #TODO: Untested

#
# 3. Advanced settings
# ==========================
  $satellites_path             = undef # /var/opt/gitlab/git-data/gitlab-satellites
  
  $backup_path                 = undef # '/var/opt/gitlab/backups'   # Relative paths are relative to Rails.root (default: tmp/backups/)
  $backup_keep_time            = undef # default: 0 (forever) (in seconds), 604800 = 1 week
  
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
  
  $extra_sign_in_text        = '[]' # Allows for company logo/name on login page. see 'tests/sign_in_text.pp' for an example
  
#
# 5. Omnibus customization
# ==========================
  $redis_port       = undef # (default: 6379)
  $postgresql_port  = undef # (default: 5432)
  $unicorn_port     = undef # (default: 8080)

  $git_data_dir     = undef # '/var/opt/gitlab/git-data'
  $gitlab_username  = undef # (default: 'gitlab')
  $gitlab_group     = undef # (default: 'gitlab')

  $redirect_http_to_https   = undef # Rrecomended to prevent users from connecting insecurely (default: false)
  $ssl_certificate          = '/etc/gitlab/ssl/gitlab.crt'
  $ssl_certificate_key      = '/etc/gitlab/ssl/gitlab.key'

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
  $svlogd_udp       = nil # transmit log messages via UDP
  $svlogd_prefix    = nil # custom prefix for log messages

  # Enterprise Only Features
  $udp_log_shipping_host = undef # e.g. '1.2.3.4' Ip of syslog server
  $udp_log_shipping_port = undef # syslog port (default: 514) 

}
