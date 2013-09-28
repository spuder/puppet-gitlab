#Could alternativly use the apt module https://forge.puppetlabs.com/puppetlabs/apt
include apt



file { '/etc/apt/sources.list.d/ruby2.0.list':
  content => "deb file:///vagrant/files/ruby2-repo /",
  mode    => 0644,
  owner   => 'root',
  group   => 'root',
  notify  => Exec['apt-get update'],
  before  => Exec['apt-get install ruby2.0'],
} 

exec {'apt-get update':
  path => '/usr/bin',
}

exec {'apt-get install ruby2.0':
  path    => '/usr/bin',
  command => 'sudo apt-get install -y --force-yes ruby2.0',
  require => Exec['apt-get update'],
}



exec { 'update-alternatives_install_ruby':
  path      => '/usr/sbin',
  command   => 'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10',
  require   => Exec ['apt-get install ruby2.0'],
}

exec { 'update-alternatives_install_gems':
  path      => '/usr/sbin',
  command   => 'update-alternatives --install /usr/local/bin/gem gem /usr/bin/gem2.0 10',
  require   => Exec ['apt-get install ruby2.0'],
}

exec { 'ruby-version':
  path      => '/usr/bin',
  command   => 'update-alternatives --set ruby /usr/bin/ruby2.0',
  user      => root, 
  require   => Exec['update-alternatives_install_ruby']
}

exec { 'gem-version':
  path      => '/usr/bin',
  command   => 'update-alternatives --set gem /usr/bin/gem2.0',
  user      => root,
  require   => Exec['update-alternatives_install_gems']
}

#update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10
#update-alternatives --set ruby /usr/bin/ruby2.0

#
#update-alternatives --install /usr/local/bin/gem gem /usr/bin/gem2.0 10
#update-alternatives --set gem /usr/bin/gem2.0 