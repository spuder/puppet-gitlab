#init -> packages -> user -> setup -> install -> config -> service
class gitlab::params {
  
  #Gitlab server settings
  $gitlab_branch          = '6-0-stable'
  $gitlabshell_branch     = 'v1.7.1'
  $git_user               = 'git'       #only change if you really know what you are doing
  $git_home               = '/home/git'
  $git_email              = 'git@someserver.net'
  $git_comment            = 'GitLab'
  $gitlab_sources         = 'git://github.com/gitlabhq/gitlabhq.git'
  $gitlabshell_sources    = 'git://github.com/gitlabhq/gitlab-shell.git'
  $gitlab_domain          = $::fqdn  
  $gitlab_repodir         = $git_home
  
  
  #Database
  $gitlab_dbtype          = 'mysql'
  $gitlab_dbname          = 'gitlabdb'
  $gitlab_dbuser          = 'gitlabdbu'
  $gitlab_dbpwd           = 'changeme'
  $gitlab_dbhost          = 'localhost'
  $gitlab_dbport          = '3306'

  #Web & Security
  $gitlab_ssl             = false
  $gitlab_ssl_cert        = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  $gitlab_ssl_key         = '/etc/ssl/private/ssl-cert-snakeoil.key'
  $gitlab_ssl_self_signed = false #Do not use self signed certs in production!
  
  #LDAP 
  $ldap_enabled           = false
  $ldap_host              = 'ldap.domain.com'
  $ldap_base              = 'dc=domain,dc=com'
  $ldap_uid               = 'uid' #Active directory = 'sAMAccountName'
  $ldap_port              = '636'
  $ldap_method            = 'ssl' 
  $ldap_bind_dn           = ''
  $ldap_bind_password     = ''
  
  #Company Branding
  $use_custom_login_logo  = false
  $company_logo_url       = 'http://placedog.com/300/93'
  $use_custom_thumbnail   = false
  $use_company_link       = false
  $company_link           = 'http://placedog.com'
  
  #User default settings
  $gitlab_gravatar        = true
  $user_create_group      = false
  $user_create_team       = false
  $user_changename        = false
  
  #Project default settings
  $project_issues         = true
  $project_merge_request  = true
  $project_wiki           = true
  $project_wall           = false
  $project_snippets       = false
  $gitlab_projects        = '10'
  $project_public_default = true #https://github.com/gitlabhq/gitlabhq/issues/5000
  
 

}


