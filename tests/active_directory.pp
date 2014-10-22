class { 'gitlab' : 
    puppet_manage_config              => true,
    puppet_manage_backups             => true,
    gitlab_branch                     => '7.4.0',
    external_url                      => 'http://192.168.33.10',
    ldap_enabled                      => true,

# These were the parameters that were used on versions < 7.4.0
    # ldap_host                         => 'foo.example.com',
    # ldap_base                         => 'DC=example,DC=com',
    # ldap_port                         => '636',
    # ldap_uid                          => 'sAMAccountName',
    # ldap_method                       => 'ssl',       
    # ldap_bind_dn                      => 'CN=foobar,CN=users,DC=example,DC=com', 
    # ldap_password                     => 'foobar',    
    # gravatar_enabled                  => true,
    # gitlab_default_can_create_group   => false,
    # gitlab_username_changing_enabled  => false,
    # gitlab_signup_enabled             => false,
    # gitlab_default_projects_features_visibility_level => 'internal',
    # ldap_sync_time                    => 3600,

# Gitlab 7.4.x ldap syntax

  ldap_servers   => ['
{
  "main" => {
    "label" => "LDAP",
    "host" => "hostname of LDAP server",
    "port" => 389,
    "uid" => "sAMAccountName",
    "method" => "plain",
    "bind_dn" => "CN=query user,CN=Users,DC=mycorp,DC=com",
    "password" => "query user password",
    "active_directory" => true,
    "allow_username_or_email_login" => true,
    "base" => "DC=mycorp,DC=com",
    "group_base" => "OU=groups,DC=mycorp,DC=com",
    "admin_group" => "",
    "sync_ssh_keys" => false,
    "sync_time" => 3600
  }
}'],

}