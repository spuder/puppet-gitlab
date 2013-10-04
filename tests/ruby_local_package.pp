# Tests how to install a deb file from a remote source
# So far none of these options work, it may be mandatory to copy the debs to the hard drive first
# https://ask.puppetlabs.com/question/3473/can-you-install-deb-file-from-the-files-directory/
# http://serverfault.com/questions/188632/how-to-update-a-package-using-puppet-and-a-deb-file



class ruby_local_package {
  
  #Use either Option 1 or Option 2 (you must comment one or the outer out)
  
  #Option 1 (not working)
  package {'ruby2.0_2.0.0.299-2_amd64.deb': 
    ensure    => installed,
    provider  => dpkg, 
    #Uncomment one of the following sources, only the source with the file on the local drive works
#    source    => 'puppet:///modules/gitlab/ruby2-repo/ruby2.0_2.0.0.299-2_amd64.deb',  
#    source    => 'puppet:///modules/gitlab/ruby2.0_2.0.0.299-2_amd64.deb', 
#    source    => 'http:///mirrors.xmission.com/ubuntu/pool/universe/r/ruby2.0/ruby2.0_2.0.0.299-2_amd64.deb', 
#    source    => '/vagrant/files/ruby2.0_2.0.0.299-2_amd64.deb',

  }
  
  #Option 2 (works)
  #Take the whole directory and recursivly put it in /home/vagrant/ 
  #http://docs.puppetlabs.com/guides/techniques.html
  file { "/home/vagrant/ruby2-0-repo":
    source  => "puppet:///modules/gitlab/ruby2-repo",
    recurse => true,
    mode    => '0755',
  }
  
  
  
#======================================
  
  #Not working
  
#  package {'libruby2': 
#    ensure    => installed,
#    name      => 'libruby2.0_2.0.0.299-2_amd64.deb',
#    provider  => dpkg, 
#	  source    => 'puppet://modules/gitlab/ruby2-repo/libruby2.0_2.0.0.299-2_amd64.deb',  
#	}
#	 package {'rake_10.0.4-1_all.deb': 
#    ensure    => installed,
#    name      => 'rake_10.0.4-1_all.deb',
#    provider  => dpkg, 
#    source    => 'puppet://modules/gitlab/ruby2-repo/rake_10.0.4-1_all.deb',  
#  }
#	 package {'rubygems-integration_1.2_all.deb': 
#    ensure    => installed,
#    name      => 'rubygems-integration_1.2_all.deb',
#    provider  => dpkg, 
#    source    => 'puppet://modules/gitlab/ruby2-repo/rubygems-integration_1.2_all.deb',  
#  }
	


}

#http://mirrors.xmission.com/ubuntu//pool/universe/r/ruby2.0/ruby2.0_2.0.0.299-2_amd64.deb  
#http://mirrors.xmission.com/ubuntu//pool/universe/r/ruby2.0/libruby2.0_2.0.0.299-2_amd64.deb  
#http://mirrors.xmission.com/ubuntu//pool/universe/r/rubygems-integration/rubygems-integration_1.2_all.deb

include ruby_local_package