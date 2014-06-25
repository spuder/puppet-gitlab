# init -> packages -> user -> setup -> install -> config -> service
class gitlab::params {
  
  # Manage Packages
  $puppet_manage_config  = false
  $puppet_manage_backups = true
  
  # Gitlab server settings
  $gitlab_branch          = '7.0.0'
  $gitlab_release         = 'enterprise' # enterprise or basic



#
# 1. GitLab app settings
# ==========================
  gitlab_email_from
  gitlab_default_projects_limit
  gitlab_default_can_create_group
  gitlab_username_changing_enabled
  gitlab_default_theme
  gitlab_signup_enabled
  gitlab_signin_enabled

  gitlab_default_projects_features_issues = true
  gitlab_default_projects_features_merge_requests = true
  gitlab_default_projects_features_wiki = true
  gitlab_default_projects_features_snippets = false
  gitlab_default_projects_features_visibility_level = 'internal' # public internal or private


  issues_tracker_redmine
  issues_tracker_redmine_title
  issues_tracker_redmine_project_url
  issues_tracker_redmine_issues_url
  issues_tracker_redmine_new_issue_url

  issues_tracker_jira
  issues_tracker_jira_title
  issues_tracker_jira_project_url
  issues_tracker_jira_issues_url
  issues_tracker_jira_new_issue_url 

  gravatar_enabled
  gravatar_plain_url
  gravatar_ssl_url


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

  $omniauth_enabled    = true
    omniauth_allow_single_sign_on
    omniauth_block_auto_created_users
  $omniauth_providers  = '[
    {
      "name" => "google_oauth2",
      "app_id" => "YOUR APP ID",
      "app_secret" => "YOUR APP SECRET",
      "args" => { "access_type" => "offline", "approval_prompt" => "" }
    }
  ]'


#
# 3. Advanced settings
# ==========================

satellites_path

# Backup
$backup_path            = 'tmp/backups'   # Relative paths are relative to Rails.root (default: tmp/backups/)
$backup_keep_time       = '0'             # default: 0 (forever) (in seconds), 604800 = 1 week

gitlab_shell_path

gitlab_shell_repos_path
gitlab_shell_hooks_path

gitlab_shell_upload_pack
gitlab_shell_receive_pack

gitlab_shell_ssh_port

git_bin_path
git_max_size
git_timeout


#
# 4. Extra customization
# ==========================

extra_google_analytics_id
extra_google_analytics_id

extra_piwik_url
extra_piwik_url
extra_piwik_site_id

extra_sign_in_text
extra_sign_in_text



  #Omnibus configuration


  $redis_port       = undef # 6379
  $postgresql_port  = undef # 5432
  $unicorn_port     = undef # 8080

  $git_data_dir     = undef # "/var/opt/gitlab/git-data"  
  $gitlab_username  = undef # "gitlab"
  $gitlab_group     = undef # "gitlab"



  $redirect_http_to_https   = undef #true or false
  $ssl_certificate          = "/etc/gitlab/ssl/gitlab.crt"
  $ssl_certificate_key      = "/etc/gitlab/ssl/gitlab.key"

  $git_uid          = 1001
  $git_gid          = 1002
  $gitlab_redis_uid = 998
  $gitlab_redis_gid = 1003
  $gitlab_psql_uid  = 997
  $gitlab_psql_gid  = 1004

  $aws_enable            = true
  $aws_access_key_id     = 'AKIA1111111111111UA'
  $aws_secret_access_key = 'secret'
  $aws_bucket            = 'my_gitlab_bucket'
  $aws_region            = 'us-east-1'

  $smtp_enable               = true
  $smtp_address              = "smtp.server"
  $smtp_port                 = 456
  $smtp_user_name            = "smtp user"
  $smtp_password             = "smtp password"
  $smtp_domain               = "example.com"
  $smtp_authentication       = "login"
  $smtp_enable_starttls_auto = true



  # Below are the default values
  $svlogd_size = 200 * 1024 * 1024 # rotate after 200 MB of log data
  $svlogd_num = 30 # keep 30 rotated log files
  $svlogd_timeout = 24 * 60 * 60 # rotate after 24 hours
  $svlogd_filter = "gzip" # compress logs with gzip
  $svlogd_udp = nil # transmit log messages via UDP
  $svlogd_prefix = nil # custom prefix for log messages

  
}
