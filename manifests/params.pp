# init -> packages -> user -> setup -> install -> config -> service
class gitlab::params {
  
  # Manage Packages
  $gitlab_manage_packages = true
  
  # Gitlab server settings
  $gitlab_branch          = '6-8-stable'
  $gitlabshell_branch     = 'v1.9.3'
  $git_user               = 'git'       # only change if you really know what you are doing
  $git_home               = '/home/git'
  $git_email              = 'git@someserver.net'
  $git_comment            = 'GitLab'
  $git_ssh_port           = '22'
  $gitlab_sources         = 'git://github.com/gitlabhq/gitlabhq.git'
  $gitlabshell_sources    = 'git://github.com/gitlabhq/gitlab-shell.git' 
  
  # Database
  $gitlab_dbtype          = 'mysql'
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

  
  # LDAP 
  $ldap_enabled           = false
  $ldap_host              = 'ldap.domain.com'
  $ldap_base              = 'dc=domain,dc=com'
  $ldap_uid               = 'uid' # Active directory = 'sAMAccountName'
  $ldap_port              = '636'
  $ldap_method            = 'ssl' # "tls" or "ssl" or "plain"
  $ldap_bind_dn           = ''
  $ldap_bind_password     = ''
  
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
  # $project_public_default = Deprecated in 6-4
  $visibility_level       = 'internal'
  
  # Backup
  $backup_path            = 'tmp/backups'   # Relative paths are relative to Rails.root (default: tmp/backups/)
  $backup_keep_time       = '0'             # default: 0 (forever) (in seconds), 604800 = 1 week
  
}
