

  class { 'mysql::server':
    config_hash => { 'root_password' => 'badpassword' }
  }#TODO: This needs to be moved to hiera or foreman

  
  class { 'gitlab' : 
	  git_user               => 'git',
	  git_home               => '/home/git',
	  git_email              => 'git@adaptivecomputing.com',
	  git_comment            => 'GitLab',
	  gitlab_sources         => 'git://github.com/gitlabhq/gitlabhq.git',
	  gitlab_branch          => '6-1-stable',
	  gitlabshell_sources    => 'git://github.com/gitlabhq/gitlab-shell.git',
	  gitlabshell_branch     => 'v1.7.1',
	  
	  gitlab_dbtype          => 'mysql',
	  gitlab_dbname          => 'gitlabdb',
	  gitlab_dbuser          => 'gitlabdbu',
	  gitlab_dbpwd           => 'changeme',
	  gitlab_dbhost          => 'localhost',
	  gitlab_dbport          => '3306',
	  gitlab_domain          => $::fqdn,
	  gitlab_repodir         => $git_home,#TODO: Can this be removed? 
	  gitlab_ssl             => false,
	  gitlab_ssl_cert        => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
	  gitlab_ssl_key         => '/etc/ssl/private/ssl-cert-snakeoil.key',
	  gitlab_ssl_self_signed => false,
	  gitlab_projects        => '10',
	  gitlab_username_change => true,
	  
	  ldap_enabled           => false,
	  ldap_host              => 'ldap.domain.com',
	  ldap_base              => 'dc=domain,dc=com',
	  ldap_uid               => 'uid',
	  ldap_port              => '636',
	  ldap_method            => 'ssl',
	  ldap_bind_dn           => '',
	  ldap_bind_password     => '',
	  }
	  
	  
  
  