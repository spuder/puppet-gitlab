# == Class: gitlab::config
#
# Optional class
# If $puppet_manage_config = true, then this module will manage /etc/gitlab/gitlab.rb
# The gitlab.rb config file is generated based on templates/gitlab-puppet.rb.erb
# if $puppet_manage_config = false, the end user may manually edit /etc/gitlab/gitlab.rb
#
# === Parameters
#
# === Examples
#
# DO NOT CALL THIS CLASS DIRECTLY, instead set $puppet_manage_config in class def
#
# class { 'gitlab' : 
#   gitlab_branch          => '7.0.0',
#   external_url           => 'http://foo.bar',
#   puppet_manage_config   => true,
#  }
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab::config inherits ::gitlab {

  $gitlab_config_dir = '/etc/gitlab'

  file { $gitlab_config_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }
  file { "${gitlab_config_dir}/gitlab.rb":
    content => template('gitlab/gitlab-puppet.rb.erb'),
    backup  => true,
    require => File[$gitlab_config_dir],
  }
    # Some versions of gitlab require nginx to be stopped before upgrading: https://github.com/gitlabhq/gitlabhq/issues/7902
  exec { 'stop gitlab':
    refreshonly => true,
    timeout     => 1800,
    command     => '/usr/bin/gitlab-ctl stop nginx',
    subscribe   => Package['gitlab'],
    notify      => Exec['/usr/bin/gitlab-ctl reconfigure'],
    before      => [ Exec['/usr/bin/gitlab-ctl reconfigure'], Exec['start gitlab'] ],
  }
  exec { '/usr/bin/gitlab-ctl reconfigure':
    refreshonly => true,
    timeout     => 1800,
    require     => File["${gitlab_config_dir}/gitlab.rb"],
    subscribe   => [ File["${gitlab_config_dir}/gitlab.rb"], Exec['stop gitlab'], Package['gitlab'] ],
    before      => Exec['start gitlab'],
  }
  exec { 'start gitlab':
    command => '/usr/bin/gitlab-ctl start',
    unless  => '/usr/bin/gitlab-ctl status',
  }


}
