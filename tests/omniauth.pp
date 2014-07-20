class { 'gitlab' :
  puppet_manage_config    => true,
  gitlab_branch           => '7.0.0',
  gitlab_release          => 'basic',
  external_url            => 'http://192.168.33.10',


# Documented here: http://doc.gitlab.com/ce/integration/omniauth.html


  omniauth_enabled => true,
  omniauth_providers   => [
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
]
}