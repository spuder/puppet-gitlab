#This is the syntax to create a mysql server in puppetlabs-mysql version < 2.0.0
#  class { 'mysql::server':
#    config_hash => { 'root_password' => 'badpassword' }
#  }

#This is the syntax to create a mysql server in puppetlabs-mysql version > 2.0.0
#Use caution as it could overwrite an existing database
  class { 'mysql::server':
    root_password   => 'foo', 
  }

  
  class { 'gitlab' : 
    gitlab_manage_packages => true,
    # git_user               => 'git',
    # git_home               => '/home/git',
    git_email              => 'git@foo.com',
    # git_comment            => 'GitLab',
    git_ssh_port           => '22',
    # gitlab_sources         => 'git://github.com/gitlabhq/gitlabhq.git',
    gitlab_branch          => '6-8-stable',
    # gitlabshell_sources    => 'git://github.com/gitlabhq/gitlab-shell.git',
    gitlabshell_branch     => 'v1.9.3',
    
    gitlab_dbtype          => 'mysql',
    gitlab_dbname          => 'gitlabdb',
    gitlab_dbuser          => 'gitlabdbu',
    gitlab_dbpwd           => 'changeme',
    gitlab_dbhost          => 'localhost',
    gitlab_dbport          => '3306',  
    gitlab_ssl             => true,
    gitlab_ssl_cert        => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    gitlab_ssl_key         => '/etc/ssl/private/ssl-cert-snakeoil.key',
    gitlab_ssl_self_signed => true, #Do not use self signed certs in production!
    gitlab_projects        => '15',
    default_servername     => 'gitlab', #If you want to change gitlab.foo.com to foobar.foo.com
    # gitlab_username_change => true,
    
    ldap_enabled           => false,
    ldap_host              => 'ldap.domain.com',
    ldap_base              => 'dc=domain,dc=com',
    ldap_uid               => 'uid',
    ldap_port              => '636',
    ldap_method            => 'ssl',
    ldap_bind_dn           => '',
    ldap_bind_password     => '',
    
    use_custom_login_logo  => true,
    use_custom_thumbnail   => false,
    use_company_link       => true,
    company_link           => 'http://failblog.cheezburger.com',
    # project_public_default => false, #Deprecated
    visibility_level       => 'internal', # New in 6-4, replaces project_public_default
    
    gitlab_gravatar        => true,
    user_create_group      => false,
    user_changename        => false,
    
    #Default Project features
    project_issues         => true,
    project_merge_request  => true,
    project_wiki           => false,
    project_wall           => false,
    project_snippets       => true,
    
    }
    
    
  
  
