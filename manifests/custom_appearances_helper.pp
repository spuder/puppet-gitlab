# == Class: gitlab::custom_appearances_helper
#
# This class deploys custom appearances helper. This can be used to
# customize the look of the sign-in screen.
#
# === Parameters
#
# [*brand_image*]
#   Path where the brand image can be fetched
# [*brand_title*]
#   Title for the main page
# [*brand_text*]
#   Customization that appears next to the brand logo (brand_image)
# [*module_pathname*]
#   Path where the appearances module is being stored (default for
#   omnibus package provided)
#
# === Examples
#
# class { 'gitlab::custom_appearances_helper':
#   brand_title => 'GitLab for Example.org',
#   brand_image => 'http://www.gravatar.com/avatar/0?s=200&d=mm',
#   brand_text  => 'Example.org is a software development group',
# }
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2015 Braiins Systems s.r.o.
#
class gitlab::custom_appearances_helper (
  $brand_title=undef,
  $brand_image=undef,
  $brand_text=undef,
  $module_pathname='/opt/gitlab/embedded/service/gitlab-rails/app/helpers/appearances_helper.rb',
  ) {

  file { $module_pathname :
    ensure  => present,
    owner   => root,
    group   => root,
    content => template('gitlab/appearances_helper.rb.erb'),
    notify  => Exec['/usr/bin/gitlab-ctl reconfigure'],
  }
}
