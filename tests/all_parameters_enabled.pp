class { 'gitlab' :

# Don't blindly apply this class. It is only used for 2 purposes:

# 1. For development to verify that all parameters are incorperated into the erb template properly
# 2. As reference to show *how* to implement each parameter


  # Manage Packages
  puppet_manage_config   => true,  # If true, puppet will manage /etc/gitlab/gitlab.rb
  puppet_manage_backups  => true,  # If true, puppet will manage cron job to backup at 2am
  puppet_manage_packages => true,  # If true, Puppet will manage openssl and postfix packages

  # Gitlab server settings
  gitlab_branch           => '7.4.0',
  gitlab_release          => 'basic', # enterprise or basic
  # gitlab_download_link  => '', #'https://secret_url/ubuntu-12.04/gitlab_7.0.0-omnibus-1_amd64.deb',

  external_url            => 'http://192.168.33.10',

#
# 1. GitLab app settings
# ==========================
  gitlab_email_from                   => 'gitlab@example.com',
  gitlab_default_projects_limit       => 10,
  gitlab_default_can_create_group     => true,
  gitlab_username_changing_enabled    => true,
  gitlab_default_theme                => 3,
  gitlab_signup_enabled               => true,
  gitlab_signin_enabled               => true,
  gitlab_ssh_host                     => '192.168.33.10',
  gitlab_restricted_visibility_levels => ['public', 'internal'],

  gitlab_default_projects_features_issues           => true, # true
  gitlab_default_projects_features_merge_requests   => true, # true
  gitlab_default_projects_features_wiki             => true, # true
  gitlab_default_projects_features_snippets         => true, # false
  gitlab_default_projects_features_visibility_level => 'public', # 'private' # public internal or private

  issues_tracker_redmine               => true,
  issues_tracker_redmine_title         => 'foo',
  issues_tracker_redmine_project_url   => 'http://foo.example.com',
  issues_tracker_redmine_issues_url    => 'http://foo.example.com',
  issues_tracker_redmine_new_issue_url => 'http://foo.example.com',

  issues_tracker_jira               => true,
  issues_tracker_jira_title         => 'foo',
  issues_tracker_jira_project_url   => 'http://foo.example.com',
  issues_tracker_jira_issues_url    => 'http://foo.example.com',
  issues_tracker_jira_new_issue_url => 'http://foo.example.com',

  gravatar_enabled    => true,
  gravatar_plain_url  => 'foo',
  gravatar_ssl_url    => 'foo',


#
# 2. Auth settings
# ==========================

  # These settings are documented in more detail at
  # https://gitlab.com/gitlab-org/gitlab-ce/blob/master/config/gitlab.yml.example#L118
  ldap_enabled   => true,
  # In gitlab 7.4, the ldap config was redefined. Gitlab enterprise supports multiple servers
  ldap_servers   => [
'{
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
}',
',',
'{
  "secondary" => {
    "label" => "LDAP 2",
    "host" => "hostname of LDAP server 2",
    "port" => 389,
    "uid" => "sAMAccountName",
    "method" => "plain",
    "bind_dn" => "CN=query user,CN=Users,DC=mycorp,DC=com",
    "password" => "query user password",
    "active_directory" => true,
    "allow_username_or_email_login" => true,
    "base" => "DC=mycorp,DC=com",
    "group_base" => "OU=groups,DC=mycorp,DC=com",
    "sync_ssh_keys" => false
  }
}'],

# Deprectated in 7.4
  # ldap_host      => 'hostname of LDAP server',
  # ldap_port      => 389, # or 636
  # ldap_uid       => 'sAMAccountName', # or 'uid'
  # ldap_method    => 'plain', # 'ssl' or 'plain'
  # ldap_bind_dn   => 'CN=query user,CN=Users,DC=mycorp,DC=com',
  # ldap_password  => 'query user password',
  # ldap_sync_time => 3600,

  # ldap_allow_username_or_email_login => true,
  # ldap_base                          => 'DC=mycorp,DC=com',

  # GitLab Enterprise Edition only
  # ldap_group_base  => '', # Example: 'OU=groups,DC=mycorp,DC=com'
  # ldap_user_filter => '', # Example: '(memberOf=CN=my department,OU=groups,DC=mycorp,DC=com)'

  # ldap_sync_ssh_keys => undef, # e.g. 'sshpublickey' - The object name in ldap where ssh keys are stored
  # ldap_admin_group   => undef, # e.g. 'GitLab administrators' - The object name in ldap that matches administrator

  omniauth_enabled                   => true,
  omniauth_allow_single_sign_on     => true,
  omniauth_block_auto_created_users => false,
  omniauth_providers                => [
  '{
    "name"   => "google_oauth2",
    "app_id" => "YOUR APP ID",
    "app_secret" => "YOUR APP SECRET",
    "args"   => { "access_type" => "offline", "approval_prompt" => "" }
  }',
  ',',
  '{ 
    "name"   => "twitter",
    "app_id" => "YOUR APP ID",
    "app_secret" =>  "YOUR APP SECRET"
  }',
  ',',
  '{ "name"   => "github",
    "app_id" => "YOUR APP ID",
    "app_secret" =>  "YOUR APP SECRET",
    "args"  => { "scope" =>  "user:email" }
  }'
],


#
# 3. Advanced settings
# ==========================
  
  satellites_path             => '/var/opt/gitlab/git-data/gitlab-satellites',
  satellites_timeout          => 60,

  # Backup
  backup_path                 => '/var/opt/gitlab/backups', #'tmp/backups'
  backup_keep_time            => 604800,

  backup_upload_connection    => 'foobar',
  backup_upload_remote_directory => 'foobar',
  
  gitlab_shell_path           => '/opt/gitlab/embedded/service/gitlab-shell/',
  
  gitlab_shell_repos_path     => '/var/opt/gitlab/git-data/repositories',
  gitlab_shell_hooks_path     => '/opt/gitlab/embedded/service/gitlab-shell/hooks/',
  
  gitlab_shell_upload_pack    => true,
  gitlab_shell_receive_pack   => true,
  
  gitlab_shell_ssh_port       => 22,
  
  git_bin_path                => '/opt/gitlab/embedded/bin/git',
  git_max_size                => 5242880, # 5 MB, Incrase to alow larger commits over https
  git_timeout                 => 10,


#
# 4. Extra customization
# ==========================

  extra_google_analytics_id => 'foo',
  
  extra_piwik_url           => 'http://foo.bar/',
  extra_piwik_site_id       => 'foo',
  
  extra_sign_in_text        => 'herp',


#
# 5. Omnibus customization
# ==========================


#  redis_port       => 6379, # 6379 # Deprecated in 7.3.0
  postgresql_port  => 5432, # 5432
  unicorn_port     => 8080, # 8080

  git_data_dir     => '/var/opt/gitlab/git-data',
  gitlab_username  => 'gitlab',
  gitlab_group     => 'gitlab',

  redirect_http_to_https   => true,
  ssl_certificate          => "/etc/gitlab/ssl/gitlab.crt",
  ssl_certificate_key      => "/etc/gitlab/ssl/gitlab.key",
  listen_addresses         => ["0.0.0.0", "[::]"],

  git_username        => 'git',
  git_groupname       => 'git',
  #git_uid            => 1001, 
  #git_gid            => 1002,
  #gitlab_redis_uid   => 998,
  #gitlab_redis_gid   => 1003,
  #gitlab_psql_uid    => 997,
  #gitlab_psql_gid    => 1004,

  aws_enable               => true, # Store images on amazon
  aws_access_key_id        => 'AKIA1111111111111UA',
  aws_secret_access_key    => 'secret',
  aws_bucket               => 'my_gitlab_bucket',
  aws_region               => 'us-east-1',

  smtp_enable               => true, # Specify your own smtp server
  smtp_address              => "smtp.server",
  smtp_port                 => 456,
  smtp_user_name            => "smtp user",
  smtp_password             => "smtp password",
  smtp_domain               => "example.com",
  smtp_authentication       => "login",
  smtp_enable_starttls_auto => true,


  # Below are the default values
  svlogd_size      => 200 * 1024 * 1024, # rotate after 200 MB of log data
  svlogd_num       => 30, # keep 30 rotated log files
  svlogd_timeout   => 24 * 60 * 60, # rotate after 24 hours
  svlogd_filter    => "gzip", # compress logs with gzip
  svlogd_udp       => nil, # transmit log messages via UDP
  svlogd_prefix    => nil, # custom prefix for log messages

  udp_log_shipping_host => '192.0.2.0', # Ip of syslog server
  udp_log_shipping_port => '514', # Optional, defaults to 514 (syslog)

  high_availability_mountpoint => '/var/foo',

}
