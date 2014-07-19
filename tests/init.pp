class { 'gitlab' :
  puppet_manage_config    => true,
  gitlab_branch           => '7.0.0',
  gitlab_release          => 'basic',
  external_url            => 'http://192.168.33.10',
  
  # SSL highly recomended
  redirect_http_to_https  => true,
}
