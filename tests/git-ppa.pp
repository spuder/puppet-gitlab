
# there are 2 ways to include a class declaration
#class { 'apt': }
include apt


apt::ppa { 'ppa:git-core/ppa': 
  notify => Exec['apt-get update'],
  
}

apt::key { 'ppa:git-core/ppa': 
    key    => 'E1DF1F24',
}



exec { 'apt-get update':
  path => '/usr/bin',
  command => 'apt-get update',
}

package { 'git-core': 
  ensure => present, 
  require => [
              Apt::Ppa['ppa:git-core/ppa'],
              Apt::Key['ppa:git-core/ppa'],
              ],
}
