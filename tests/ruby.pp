
#Don't use the puppetlabs crap ruby module

#instead use
#puppet module install example42/ruby


#Atomaka's way of installing this with jfrymans module
#class { 'ruby':
#    ruby_package     => 'ruby1.9.3',
#    rubygems_package => 'rubygems1.9.1',
#    rubygems_update  => false,
#}
  
  
#example42's way of installing ruby (takes a while)
class { 'ruby':
  version             => '1.9.3-p392',
  compile_from_source => true,
  install_rubygems    => true,
}
#include ruby

# This fails, i opened an issue on it https://github.com/example42/puppet-ruby/issues/2



#update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby2.0 10
#update-alternatives --set ruby /usr/bin/ruby2.0

#
#update-alternatives --install /usr/local/bin/gem gem /usr/bin/gem2.0 10
#update-alternatives --set gem /usr/bin/gem2.0 