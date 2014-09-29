# == Class: gitlab::service
#
# If $puppet_manage_config = true, then this manifest will ensure gitlab is running
# Only really required when performing an upgrade of gitlab. See issue #81
# https://github.com/spuder/puppet-gitlab/issues/81
# === Parameters
#
# === Examples
#
#
# === Authors
#
# Spencer Owen <owenspencer@gmail.com>
#
# === Copyright
#
# Copyright 2014 Spencer Owen, unless otherwise noted.
#
class gitlab::service inherits ::gitlab {

  exec { 'start gitlab':
    command => '/usr/bin/gitlab-ctl start',
  }
}
