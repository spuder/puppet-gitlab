# init -> packages -> user -> setup -> install -> config -> service
class gitlab::params {
  
  # Manage Packages
  $puppet_manage_config  = undef
  $puppet_manage_backups = true
  
  # Gitlab server settings
  $gitlab_branch          = '7.0.0'
  $gitlab_release         = 'enterprise' # enterprise or basic

  $external_url           = undef

#
# 1. GitLab app settings
# ==========================
  $gitlab_email_from                 = undef
  $gitlab_default_projects_limit     = undef
  $gitlab_default_can_create_group   = undef
  $gitlab_username_changing_enabled  = undef
  $gitlab_default_theme              = undef # 1 Basic, 2 Mars, 3 Modern, 4 Gray, 5 Color
  $gitlab_signup_enabled             = undef
  $gitlab_signin_enabled             = undef

  $gitlab_default_projects_features_issues           = undef # true
  $gitlab_default_projects_features_merge_requests   = undef # true
  $gitlab_default_projects_features_wiki             = undef # true
  $gitlab_default_projects_features_snippets         = undef # false
  $gitlab_default_projects_features_visibility_level = undef # 'private' # public internal or private

  $issues_tracker_redmine               = undef # true | false
  $issues_tracker_redmine_title         = undef # 'title'
  $issues_tracker_redmine_project_url   = undef # 'http://foo/bar'
  $issues_tracker_redmine_issues_url    = undef # 'http://foo/bar'
  $issues_tracker_redmine_new_issue_url = undef # 'http://foo/bar'

  $issues_tracker_jira               = undef # true | false
  $issues_tracker_jira_title         = undef # 'foo'
  $issues_tracker_jira_project_url   = undef # 'http://foo/bar'
  $issues_tracker_jira_issues_url    = undef # 'http://foo/bar'
  $issues_tracker_jira_new_issue_url = undef # 'http://foo/bar'

  $gravatar_enabled    = undef # true | false
  $gravatar_plain_url  = undef # 'http://foo/bar'
  $gravatar_ssl_url    = undef # 'https://foo/bar'


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
  $ldap_base                          = 'DC=mycorp,DC=com'

  # GitLab Enterprise Edition only
  $ldap_group_base  = '' # Example: 'OU=groups,DC=mycorp,DC=com'
  $ldap_user_filter = '' # Example: '(memberOf=CN=my department,OU=groups,DC=mycorp,DC=com)'

  $omniauth_enabled                  = undef
  $omniauth_allow_single_sign_on     = undef #TODO: Implement in erb template
  $omniauth_block_auto_created_users = undef #TODO: Implement in erb template
  $omniauth_providers  = '[]' #TODO: Untested


#
# 3. Advanced settings
# ==========================
  
  $satellites_path             = undef # /var/opt/gitlab/git-data/gitlab-satellites
  
  # Backup
  $backup_path                 = undef # '/var/opt/gitlab/backups'   # Relative paths are relative to Rails.root (default: tmp/backups/)
  $backup_keep_time            = undef # default: 0 (forever) (in seconds), 604800 = 1 week
  
  $gitlab_shell_path           = undef # '/opt/gitlab/embedded/service/gitlab-shell/'
  
  $gitlab_shell_repos_path     = undef # '/var/opt/gitlab/git-data/repositories'
  $gitlab_shell_hooks_path     = undef # /opt/gitlab/embedded/service/gitlab-shell/hooks/
  
  $gitlab_shell_upload_pack    = undef # true
  $gitlab_shell_receive_pack   = undef # true
  
  $gitlab_shell_ssh_port       = undef # 22
  
  $git_bin_path                = undef # /opt/gitlab/embedded/bin/git
  $git_max_size                = undef # 5242880 (5 MB)
  $git_timeout                 = undef # 10


#
# 4. Extra customization
# ==========================
  
  $extra_google_analytics_id = undef
  
  $extra_piwik_url           = undef
  $extra_piwik_site_id       = undef
  
  $extra_sign_in_text        = undef
  
  
#
# 5. Omnibus customization
# ==========================


  $redis_port       = undef # 6379
  $postgresql_port  = undef # 5432
  $unicorn_port     = undef # 8080

  $git_data_dir     = undef # "/var/opt/gitlab/git-data"  
  $gitlab_username  = undef # "gitlab"
  $gitlab_group     = undef # "gitlab"

  $redirect_http_to_https   = undef #true or false
  $ssl_certificate          = "/etc/gitlab/ssl/gitlab.crt"
  $ssl_certificate_key      = "/etc/gitlab/ssl/gitlab.key"

  $git_uid            = undef #1001
  $git_gid            = undef #1002
  $gitlab_redis_uid   = undef #998
  $gitlab_redis_gid   = undef #1003
  $gitlab_psql_uid    = undef #997
  $gitlab_psql_gid    = undef #1004

  $aws_enable               = false 
  $aws_access_key_id        = 'AKIA1111111111111UA'
  $aws_secret_access_key    = 'secret'
  $aws_bucket               = 'my_gitlab_bucket'
  $aws_region               = 'us-east-1'

  $smtp_enable               = false
  $smtp_address              = "smtp.server"
  $smtp_port                 = 456
  $smtp_user_name            = "smtp user"
  $smtp_password             = "smtp password"
  $smtp_domain               = "example.com"
  $smtp_authentication       = "login"
  $smtp_enable_starttls_auto = true


  # Below are the default values
  $svlogd_size      = 200 * 1024 * 1024 # rotate after 200 MB of log data
  $svlogd_num       = 30 # keep 30 rotated log files
  $svlogd_timeout   = 24 * 60 * 60 # rotate after 24 hours
  $svlogd_filter    = "gzip" # compress logs with gzip
  $svlogd_udp       = nil # transmit log messages via UDP
  $svlogd_prefix    = nil # custom prefix for log messages

  
}
