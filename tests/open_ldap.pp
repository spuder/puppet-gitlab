# https://gitlab.com/gitlab-org/cookbook-gitlab/blob/master/doc/open_LDAP.md
# This class is not complete. Pull requests encouraged

class { 'gitlab' : 
    puppet_manage_config              => true,
    puppet_manage_backups             => true,
    gitlab_branch                     => '7.2.1',
    external_url                      => 'http://192.168.33.10',
    ldap_enabled                      => true,
    ldap_host                         => 'foo.example.com',
    ldap_base                         => '',
    ldap_port                         => '',
    ldap_uid                          => 'uid',
    ldap_method                       => 'ssl',
    ldap_bind_dn                      => '', 
    ldap_password                     => 'foobar',
    gravatar_enabled                  => true,
    gitlab_default_can_create_group   => false,
    gitlab_username_changing_enabled  => false,
    gitlab_signup_enabled             => false,
    gitlab_default_projects_features_visibility_level => 'internal',
    ldap_sync_time                    => 3600,
}