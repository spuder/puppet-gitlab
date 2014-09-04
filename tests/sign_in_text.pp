class { 'gitlab' :
  puppet_manage_config    => true,
  gitlab_branch           => '7.2.1',
  gitlab_release          => 'basic',
  external_url            => 'http://192.168.33.10',
  
  # The text and images that will appear on the login screen
  # Parsed with Markdown
  # Screenshot - http://cl.ly/image/463I0m2z1H34/Safari.png
  
  extra_sign_in_text      => [
'![foo](http://placekitten.com/303/200)  

**Visit us at [placekitten.com](http://placekitten.com/300/200)**

You can write **limited** markdown _here_  
Images are best if 303 pixels wide
'],
}
