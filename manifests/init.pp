# == Class: gitlab
#
# init manifest for gitlab class
#
# === Parameters
#
# See params.pp for full documentation of parameters
#
# [*puppet_manage_config*]
#   default => true
#   /etc/gitlab/gitlab.rb will be managed by puppet
# 
# [*puppet_manage_backups*]
#   default => true
#   Includes backup.pp which sets cron job to run rake task
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

  $gitlab_email_from                = $::gitlab::params::gitlab_email_from,
  $gitlab_default_projects_limit    = $::gitlab::params::gitlab_default_projects_limit,
  $gitlab_default_can_create_group  = $::gitlab::params::gitlab_default_can_create_group,
  $gitlab_username_changing_enabled = $::gitlab::params::gitlab_username_changing_enabled,
  $gitlab_default_theme             = $::gitlab::params::gitlab_default_theme,
  $gitlab_signup_enabled            = $::gitlab::params::gitlab_signup_enabled,
  $gitlab_signin_enabled            = $::gitlab::params::gitlab_signin_enabled,

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
    info('Puppet is not manageing /opt/gitlab/gitlab.rb because $puppet_manage_config is true')
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
    warning('Puppet is not creating gitlab backups, recomend setting $puppet_manage_backups => true')
  }

  # Ensure high_availability_mountpoint is only used with gitlab > 7.2.x
  if $high_availability_mountpoint {
    if versioncmp( $gitlab_branch, '7.2.0') < 0 {
      fail("high_availability_mountpoint is only available in gitlab >= 7.2.0, found \'${gitlab_branch}\'")
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
  
  # If all 3 $puppet_manage_* parametrs are false, then just install gitlab
  include ::gitlab::install

}# end gitlab

