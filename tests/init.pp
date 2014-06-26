
class { 'gitlab' : 
  puppet_manage_config  => true,
  gitlab_branch         => '7.0.0',
  gitlab_release        => 'basic',
  external_url          => 'http://gitlab.example.com',
}
