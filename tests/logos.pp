
  
  
#  #Change thumbnail icon to logo-white.png (used on dark backgrounds)
#  if $gitlab::custom_login_icon == 'true' {
#    warning("Icon is true")
#  }
#  else {
#    warning("Icon is not true")
#    
#    exec {'/usr/bin/touch /tmp/foo':
#    }
#    
#    
#  }
#  
include gitlab

case "${gitlab::use_custom_login_logo}" {
  'true': 
  {
      warning("Icon is true")
  }#end true
  
  'false':
  {
      warning("Icon is false")
    
	    file{"${gitlab::git_home}/app/assets/images/logo-white.png":
	        content => template("gitlab/icons/logo-white.png"),
	        owner   => "${gitlab::git_user}",
	        group   => 'git',
	        mode    => '0644',
	    }
	    file{"${gitlab::git_home}/app/assets/images/logo-black.png":
	        content => template("gitlab/icons/logo-black.png"),
	        owner   => "${gitlab::git_user}",
	        group   => 'git',
	        mode    => '0644',
	    }
  }#end false
  
}#end case