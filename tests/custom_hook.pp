# This example will result in the contents of the source file being placed
# in /var/opt/gitlab/git-data/repositories/my_group/my_project.git/custom_hooks/post-receive
gitlab::custom_hook { 'my_custom_hook':
  namespace       => 'my_group',
  project         => 'my_project',
  type            => 'post-receive',
  source          => 'puppet:///modules/my_module/post-receive',
}

# This example will result in the contents of the template being placed
# in /var/opt/gitlab/git-data/repositories/my_group/my_project.git/custom_hooks/pre-receive
gitlab::custom_hook { 'my_custom_pre_receive_hook':
  namespace       => 'my_group',
  project         => 'my_project',
  type            => 'pre-receive',
  content         => template('my_module/pre-receive.erb'),
}
