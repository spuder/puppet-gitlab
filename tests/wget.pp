  include wget
  
  file { ['/packages/','/packages/ruby2-0-repo'] :
    ensure    => directory,
  }
  
  wget::fetch { 'wget libruby' :
    source       => 'http://mirrors.xmission.com/ubuntu//pool/universe/r/ruby2.0/libruby2.0_2.0.0.299-2_amd64.deb',
    destination  => '/packages/ruby2-0-repo/libruby2.0_2.0.0.299-2_amd64.deb',
    timeout      => 0,
    verbose      => false,

  }
   wget::fetch { 'wget ruby2.0' :
    source       => 'http://mirrors.xmission.com/ubuntu//pool/universe/r/ruby2.0/ruby2.0_2.0.0.299-2_amd64.deb',
    destination  => '/packages/ruby2-0-repo/ruby2.0_2.0.0.299-2_amd64.deb',
    timeout      => 0,
    verbose      => false,
  
  }
  wget::fetch { 'wget ruby2.0gems' :
    source       => 'http://mirrors.xmission.com/ubuntu//pool/universe/r/rubygems-integration/rubygems-integration_1.2_all.deb',
    destination  => '/packages/ruby2-0-repo/rubygems-integration_1.2_all.deb',
    timeout      => 0,
    verbose      => false,    
  }
  wget::fetch { 'wget rake' :
    source       => 'http://mirrors.xmission.com/ubuntu//pool/main/r/rake/rake_10.0.4-1_all.deb',
    destination  => '/packages/ruby2-0-repo/rake_10.0.4-1_all.deb',
    timeout      => 0,
    verbose      => false,
  }
  
  file { 'Packages.gz':
    source   => 'puppet:///modules/gitlab/Packages.gz',
    path      => '/packages/ruby2-0-repo/Packages.gz',
  }
  
  file { '/etc/apt/sources.list.d/ruby2.0.list':
    content => "deb file:///packages/ruby2-0-repo /",
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
  }