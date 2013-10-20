class { 'ruby':
  ruby_package     => 'ruby1.9.1-full',
  rubygems_package => 'rubygems1.9.1',
  gems_version     => 'latest',
}

exec {'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10':
  command => 'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10',
  
}
exec {'update-alternatives --set ruby /usr/bin/ruby1.9.1':
  command => 'update-alternatives --set ruby /usr/bin/ruby1.9.1',
  require => Exec['update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 10'],
  
}
exec {'update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 10':
  command => 'update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 10 ',
  
}
exec {'update-alternatives --set gem /usr/bin/gem1.9.1':
  command => 'update-alternatives --set gem /usr/bin/gem1.9.1',
  require => Exec['update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 10'],
  
}
