  class { 'ruby':
    ruby_package      =>  'ruby1.9.1-full',
    rubygems_package  =>  'rubygems1.9.1',
    rubygems_update   =>  true,
    gems_version      =>  'latest',
  }
