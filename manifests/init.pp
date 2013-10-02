class gitlab (
    #Gitlab server settings
    $gitlab_branch          = $gitlab::params::gitlab_branch,
    $gitlabshell_branch     = $gitlab::params::gitlabshell_branch,
    $git_user               = $gitlab::params::git_user,
    $git_home               = $gitlab::params::git_home,
    $git_email              = $gitlab::params::git_email,
    $git_comment            = $gitlab::params::git_comment,
    $gitlab_sources         = $gitlab::params::gitlab_sources,
    $gitlabshell_sources    = $gitlab::params::gitlabshell_sources,
    
    #Database
    $gitlab_dbtype          = $gitlab::params::gitlab_dbtype,
    $gitlab_dbname          = $gitlab::params::gitlab_dbname,
    $gitlab_dbuser          = $gitlab::params::gitlab_dbuser,
    $gitlab_dbpwd           = $gitlab::params::gitlab_dbpwd,
    $gitlab_dbhost          = $gitlab::params::gitlab_dbhost,
    $gitlab_dbport          = $gitlab::params::gitlab_dbport,
    $gitlab_domain          = $gitlab::params::gitlab_domain,
    $gitlab_repodir         = $gitlab::params::gitlab_repodir,
    
    #Web & Security
    $gitlab_ssl             = $gitlab::params::gitlab_ssl,
    $gitlab_ssl_cert        = $gitlab::params::gitlab_ssl_cert,
    $gitlab_ssl_key         = $gitlab::params::gitlab_ssl_key,
    $gitlab_ssl_self_signed = $gitlab::params::gitlab_ssl_self_signed,
    
    #LDAP
    $ldap_enabled           = $gitlab::params::ldap_enabled,
    $ldap_host              = $gitlab::params::ldap_host,
    $ldap_base              = $gitlab::params::ldap_base,
    $ldap_uid               = $gitlab::params::ldap_uid,
    $ldap_port              = $gitlab::params::ldap_port,
    $ldap_method            = $gitlab::params::ldap_method,
    $ldap_bind_dn           = $gitlab::params::ldap_bind_dn,
    $ldap_bind_password     = $gitlab::params::ldap_bind_password,
    
    #Company Branding
    $custom_login_icon      = $gitlab::params::custom_login_icon,#TODO:Rename to logo
    $custom_thumbnail_icon  = $gitlab::params::custom_thumbnail_icon,#TODO:Rename to logo
    
    #User default settings
    $gitlab_gravatar        = $gitlab::params::gitlab_gravatar,
    $user_create_group      = $gitlab::params::user_create_group,
    $user_create_team       = $gitlab::params::user_create_team,
    $user_changename        = $gitlab::params::user_changename,
    
    #Project default features
    $project_issues         = $gitlab::params::project_issues,
    $project_merge_request  = $gitlab::params::project_merge_request,
    $project_wiki           = $gitlab::params::project_wiki,
    $project_wall           = $gitlab::params::project_wall,
    $project_snippets       = $gitlab::params::project_snippets,
    $gitlab_projects        = $gitlab::params::gitlab_projects,
    
    
    
  ) inherits gitlab::params {
    
	case $::osfamily {
	  Debian: {
	    debug("A debian os was detected: ${::osfamily}")
	  }
	  Redhat: {
	    warning("${::osfamily} not fully tested with ${gitlab_branch}")
	  }
	  default: {
	    fail("${::osfamily} not supported yet")
	  }
	}
	
	#Include all resources
	include gitlab::packages
	include gitlab::user
	include gitlab::setup
	include gitlab::install
	include gitlab::config
	include gitlab::service
	
	anchor { 'gitlab::begin':}
	anchor { 'gitlab::end':}
	
	
	#Installation order
	Anchor['gitlab::begin']      ->
	 Class['::gitlab::packages'] -> 
	 Class['::gitlab::user']     ->
	 Class['::gitlab::setup']    ->
	 Class['::gitlab::install']  ->
	 Class['::gitlab::config']   ->
	 Class['::gitlab::service']  ->
  Anchor['gitlab::end']
	 
    
    
    
    
    
}#end gitlab
    
    
    
  

