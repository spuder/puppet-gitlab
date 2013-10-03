

  class { 'mysql::server':
    config_hash => { 'root_password' => 'badpassword' }
  }#TODO: This needs to be moved to hiera or foreman

  
  class { 'gitlab' : 
#	  git_user               => 'git',
#	  git_home               => '/home/git',
	  git_email              => 'git@adaptivecomputing.com',
#	  git_comment            => 'GitLab',
#	  gitlab_sources         => 'git://github.com/gitlabhq/gitlabhq.git',
	  gitlab_branch          => '6-1-stable',
#	  gitlabshell_sources    => 'git://github.com/gitlabhq/gitlab-shell.git',
	  gitlabshell_branch     => 'v1.7.1',
	  
	  gitlab_dbtype          => 'mysql',
	  gitlab_dbname          => 'gitlabdb',
	  gitlab_dbuser          => 'gitlabdbu',
	  gitlab_dbpwd           => 'changeme',
	  gitlab_dbhost          => 'localhost',
	  gitlab_dbport          => '3306',
#	  gitlab_domain          => $::fqdn,
#	  gitlab_repodir         => $git_home,
	  gitlab_ssl             => false,#TODO: remove wildcard from gitlab.nginx-gitlab.conf.erb
	  gitlab_ssl_cert        => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
	  gitlab_ssl_key         => '/etc/ssl/private/ssl-cert-snakeoil.key',
	  gitlab_ssl_self_signed => false,
	  gitlab_projects        => '10',
	  #gitlab_username_change => true,
	  
	  ldap_enabled           => false,
	  ldap_host              => 'ldap.domain.com',
	  ldap_base              => 'dc=domain,dc=com',
	  ldap_uid               => 'uid',
	  ldap_port              => '636',
	  ldap_method            => 'ssl',
	  ldap_bind_dn           => '',
	  ldap_bind_password     => '',
	  
	  use_custom_login_logo  => false,
	  use_custom_thumbnail   => false,
	  use_company_link       => false,
	  company_link           => 'http://failblog.cheezburger.com',
	  
	  gitlab_gravatar        => true,
	  user_create_group      => false,
	  user_create_team       => false,
	  user_changename        => false,
	  
	  #Default Project features
	  project_issues         => true,
	  project_merge_request  => true,
	  project_wiki           => false,
	  project_wall           => false,
	  project_snippets       => true,
	  
	  }
	  
	  
  
  