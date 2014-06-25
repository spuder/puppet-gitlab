# init -> packages -> user -> setup -> install -> config -> service
class gitlab::params {
  
  # Manage Packages
  $puppet_manage_config  = false
  $puppet_manage_backups = true
  
  # Gitlab server settings
  $gitlab_branch          = '7.0.0'
  $gitlab_release         = 'basic' # enterprise or basic
  # $git_home               = '/home/git'
  $git_email              = 'example@example.com'
  $git_comment            = 'GitLab'
  $git_ssh_port           = '22'

  
  # Database
  $gitlab_dbname          = 'gitlabhq_production'
  $gitlab_dbuser          = 'gitlab'
  $gitlab_dbpwd           = 'changeme'
  $gitlab_dbhost          = 'localhost'
  $gitlab_dbport          = '3306'

  # Web & Security
  $gitlab_ssl             = false
  $gitlab_ssl_cert        = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  $gitlab_ssl_key         = '/etc/ssl/private/ssl-cert-snakeoil.key'
  $gitlab_ssl_self_signed = false # Do not use self signed certs in production!
  $default_servername     = 'gitlab' # example gitlab.foo.com  

  
  # # LDAP 
  # $ldap_enabled           = false
  # $ldap_host              = 'ldap.domain.com'
  # $ldap_base              = 'dc=domain,dc=com'
  # $ldap_uid               = 'uid' # Active directory = 'sAMAccountName'
  # $ldap_port              = '636'
  # $ldap_method            = 'ssl' # "tls" or "ssl" or "plain"
  # $ldap_bind_dn           = ''
  # $ldap_bind_password     = ''
  
  # Company Branding
  $use_custom_login_logo  = false
  $company_logo_url       = 'http://placepuppy.it/300/110'
  $use_custom_thumbnail   = false
  $use_company_link       = false
  $company_link           = '[Learn more about foo](http://failblog.cheezburger.com)'
  
  # User default settings
  $gitlab_gravatar        = true
  $user_create_group      = false
  $user_changename        = false
  
  # Project default settings
  $project_issues         = true
  $project_merge_request  = true
  $project_wiki           = true
  $project_wall           = false
  $project_snippets       = false
  $gitlab_projects        = '15'
  $visibility_level       = 'internal'
  
  # # Backup
  # $backup_path            = 'tmp/backups'   # Relative paths are relative to Rails.root (default: tmp/backups/)
  # $backup_keep_time       = '0'             # default: 0 (forever) (in seconds), 604800 = 1 week

  #Omnibus configuration

  # Define port numbers as strings
  $redis_port       = undef # 6379
  $postgresql_port  = undef # 5432
  $unicorn_port     = undef # 8080

  $git_data_dir     = undef # "/var/opt/gitlab/git-data"  
  $gitlab_username  = undef # "gitlab"
  $gitlab_group     = undef # "gitlab"

  # These settings are documented in more detail at
  # https://gitlab.com/gitlab-org/gitlab-ce/blob/master/config/gitlab.yml.example#L118
  $ldap_enabled = true
  $ldap_host = 'hostname of LDAP server'
  $ldap_port = 389 # or 636
  $ldap_uid = 'sAMAccountName' # or 'uid'
  $ldap_method = 'plain' # 'ssl' or 'plain'
  $ldap_bind_dn = 'CN=query user,CN=Users,DC=mycorp,DC=com'
  $ldap_password = 'query user password'

  $ldap_allow_username_or_email_login = true
  $ldap_base = 'DC=mycorp,DC=com'

  # GitLab Enterprise Edition only
  $ldap_group_base  = '' # Example: 'OU=groups,DC=mycorp,DC=com'
  $ldap_user_filter = '' # Example: '(memberOf=CN=my department,OU=groups,DC=mycorp,DC=com)'

  # external_url "https://gitlab.example.com"

  $redirect_http_to_https   = true
  $ssl_certificate          = "/etc/gitlab/ssl/gitlab.crt"
  $ssl_certificate_key      = "/etc/gitlab/ssl/gitlab.key"

  $git_uid = 1001
  $git_gid = 1002
  $gitlab_redis_uid = 998
  $gitlab_redis_gid = 1003
  $gitlab_psql_uid = 997
  $gitlab_psql_gid = 1004

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

  $omniauth_enabled    = true
  $omniauth_providers  = '[
    {
      "name" => "google_oauth2",
      "app_id" => "YOUR APP ID",
      "app_secret" => "YOUR APP SECRET",
      "args" => { "access_type" => "offline", "approval_prompt" => "" }
    }
  ]'

  # Below are the default values
  $svlogd_size = 200 * 1024 * 1024 # rotate after 200 MB of log data
  $svlogd_num = 30 # keep 30 rotated log files
  $svlogd_timeout = 24 * 60 * 60 # rotate after 24 hours
  $svlogd_filter = "gzip" # compress logs with gzip
  $svlogd_udp = nil # transmit log messages via UDP
  $svlogd_prefix = nil # custom prefix for log messages

  
}
