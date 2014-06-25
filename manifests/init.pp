# init -> packages -> user -> setup -> install -> config -> service
class gitlab (

    $puppet_manage_config = $gitlab::params::puppet_manage_config,
    # Gitlab server settings
    $gitlab_branch          = $gitlab::params::gitlab_branch,
    $gitlab_release         = $gitlab::params::gitlab_release,
    $git_user               = $gitlab::params::git_user,
    $git_home               = $gitlab::params::git_home,
    $git_email              = $gitlab::params::git_email,
    $git_comment            = $gitlab::params::git_comment,
    $git_ssh_port           = $gitlab::params::git_ssh_port,
    
    # Database
    $gitlab_dbname          = $gitlab::params::gitlab_dbname,
    $gitlab_dbuser          = $gitlab::params::gitlab_dbuser,
    $gitlab_dbpwd           = $gitlab::params::gitlab_dbpwd,
    $gitlab_dbhost          = $gitlab::params::gitlab_dbhost,
    $gitlab_dbport          = $gitlab::params::gitlab_dbport,
    
    # Web & Security
    $gitlab_ssl             = $gitlab::params::gitlab_ssl,
    $gitlab_ssl_cert        = $gitlab::params::gitlab_ssl_cert,
    $gitlab_ssl_key         = $gitlab::params::gitlab_ssl_key,
    $gitlab_ssl_self_signed = $gitlab::params::gitlab_ssl_self_signed,
    $default_servername     = $gitlab::params::default_servername, 
    
    # LDAP
    $ldap_enabled           = $gitlab::params::ldap_enabled,
    $ldap_host              = $gitlab::params::ldap_host,
    $ldap_base              = $gitlab::params::ldap_base,
    $ldap_uid               = $gitlab::params::ldap_uid,
    $ldap_port              = $gitlab::params::ldap_port,
    $ldap_method            = $gitlab::params::ldap_method,
    $ldap_bind_dn           = $gitlab::params::ldap_bind_dn,
    $ldap_bind_password     = $gitlab::params::ldap_bind_password,
    
    # Company Branding
    $use_custom_login_logo  = $gitlab::params::use_custom_login_logo,
    $company_logo_url       = $gitlab::params::company_logo_url,
    $use_custom_thumbnail   = $gitlab::params::use_custom_thumbnail,
    $use_company_link       = $gitlab::params::use_company_link,
    $company_link           = $gitlab::params::company_link,
    
    # User default settings
    $gitlab_gravatar        = $gitlab::params::gitlab_gravatar,
    $user_create_group      = $gitlab::params::user_create_group,
    $user_changename        = $gitlab::params::user_changename,
    
    # Project default settings
    $project_issues         = $gitlab::params::project_issues,
    $project_merge_request  = $gitlab::params::project_merge_request,
    $project_wiki           = $gitlab::params::project_wiki,
    $project_wall           = $gitlab::params::project_wall,
    $project_snippets       = $gitlab::params::project_snippets,
    $gitlab_projects        = $gitlab::params::gitlab_projects,
    $visibility_level       = $gitlab::params::visibility_level,
    
    # Backup 
    $backup_path            = $gitlab::params::backup_path,
    $backup_keep_time       = $gitlab::params::backup_keep_time, 


    $redis_port             = $gitlab::params::redis_port,

  ) inherits ::gitlab::params {


  # Gitlab only supplies omnibus downloads for few select operating systems
  # Warn the user they may be using an unsupported OS
  # https://about.gitlab.com/downloads/
  case $operatingsystemrelease {
    '12.04': {}
    '14.04': {}
    '7.5':   {}
    '6.5':   {}
    default: { warning("${operatingsystem} ${operatingsystemrelease} is not on approved list,\
      download may fail. See https://about.gitlab.com/downloads/ for supported OS's"
    ) }
  }


  if $puppet_manage_config == true {
    notice("Puppet will manage the configuration file because \$puppet_manage_config is true")
    include gitlab::install
    include gitlab::config

    anchor { 'gitlab::begin':}
    anchor { 'gitlab::end':}

    Anchor['gitlab::begin'] ->
      Class['::gitlab::install'] ->
      Class['::gitlab::config']  ->
    Anchor['gitlab::end']
  }
  else {
    notice("Puppet will not manage the configuration file because \$puppet_manage_config is false")
    include gitlab::install
  }


  if $puppet_manage_backups {
    include gitlab::backup
  }

}# end gitlab

