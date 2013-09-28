#puppet module install eirc/single_user_rvm
#https://forge.puppetlabs.com/eirc/single_user_rvm

#class { 'single_user_rvm': }
single_user_rvm::install { 'vagrant': }



#single_user_rvm::install_ruby { 'ruby-1.9.3-p392': user => 'vagrant' }
