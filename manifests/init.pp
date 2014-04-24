# init -> packages -> user -> setup -> install -> config -> service
class gitlab (

    # Manage packages
    $gitlab_manage_packages = $gitlab::params::gitlab_manage_packages,
    
    # Gitlab server settings
    $gitlab_branch          = $gitlab::params::gitlab_branch,
    $gitlabshell_branch     = $gitlab::params::gitlabshell_branch,
    $git_user               = $gitlab::params::git_user,
    $git_home               = $gitlab::params::git_home,
    $git_email              = $gitlab::params::git_email,
    $git_comment            = $gitlab::params::git_comment,
    $git_ssh_port           = $gitlab::params::git_ssh_port,
    $gitlab_sources         = $gitlab::params::gitlab_sources,
    $gitlabshell_sources    = $gitlab::params::gitlabshell_sources,
    
    # Database
    $gitlab_dbtype          = $gitlab::params::gitlab_dbtype,
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
    
    # Deprecated in 1.0.0
    $gitlab_repodir   = '',
    $gitlab_domain    = '',
    $user_create_team = '',
    
    # Deprecated in 2.0.0
    $project_public_default = ''

  ) inherits gitlab::params {

	case $::osfamily {
	  Debian: {
	    debug("A debian os was detected: ${::osfamily}")
	  }
	  default: {
	    fail("${::osfamily} not supported yet")
	  }
	}

# Check if removed flags are present
	if $gitlab_repodir != '' {
	  fail('The flag, $gitlab_repodir is no longer a valid parameter, please remove from your manifests')
	}
  if $gitlab_domain != '' {
    fail('The flag, $gitlab_domain is no longer a valid parameter, please remove from your manifests')
  }
  if $user_create_team != '' {
    fail('The flag, $user_create_team is no longer a valid parameter, please remove from your manifests')
  }

# Check if flags removed in 6-4 are present  
   if $project_public_default != '' {
    if $gitlab_branch >= '6-4-stable' {
      fail('Gitlab 6-4 and newer replaced $project_public_default with $visibility_level, please update your manifests. See http://bit.ly/1egMAW2')
    }
  }
  
# Test if pupet 3.0, required for scope lookup in erb templates
  if $::puppetversion <= '3.0.0' {
    fail("Module requires puppet 3.0 or greater, you have ${::puppetversion}")
  }
	



# Allow user to install nginx, mysql, git ect.. packages separately
  if $gitlab_manage_packages == true {
    notice("Gitlab will manage packages because gitlab_manage_packages is: ${gitlab_manage_packages} ")
    
    include gitlab::packages
    include gitlab::user
    include gitlab::setup
    include gitlab::install
    include gitlab::config
    include gitlab::service
  
    anchor { 'gitlab::begin':}
    anchor { 'gitlab::end':}
    # Installation order
    Anchor['gitlab::begin']      ->
     Class['::gitlab::packages'] ->
     Class['::gitlab::user']     ->
     Class['::gitlab::setup']    ->
     Class['::gitlab::install']  ->
     Class['::gitlab::config']   ->
     Class['::gitlab::service']  ->
    Anchor['gitlab::end']
      
  }
  else {
    notice("You must install packages manually because gitlab_manage_packages is: ${gitlab_manage_packages}, see manifests/packages.pp")
    
    include gitlab::user
    include gitlab::setup
    include gitlab::install
    include gitlab::config
    include gitlab::service
  
    anchor { 'gitlab::begin':}
    anchor { 'gitlab::end':}
    # Installation order
    Anchor['gitlab::begin']      ->
     Class['::gitlab::user']     ->
     Class['::gitlab::setup']    ->
     Class['::gitlab::install']  ->
     Class['::gitlab::config']   ->
     Class['::gitlab::service']  ->
    Anchor['gitlab::end']
  }
    



}# end gitlab
    
    
    
  
