class gitlab::service inherits gitlab {
  
#TODO: run an if statement to choose the correct init script (gitlab.init.6-1.erb, ect..)
  #init script
  file { '/etc/init.d/gitlab':
    ensure    => file,
    content   => template('gitlab/init.6-1.erb'), #TODO make this point to a variable
    owner     => root,
    group     => root,
    mode      => '0755',
    before    => Service['gitlab'], #TODO, make this subscribe
  }
  
  #gitlab service
	service { 'gitlab' :
	  ensure    => running,
	  enable    => true,
	  #hasrestart  => true,
	  #hasstatus   => true,  
	}
	#TODO: Figure out why puppet says gitlab was started, but doesnt' actually start.
#	Notice: /Stage[main]/Gitlab::Service/File[/etc/init.d/gitlab]/ensure: defined content as '{md5}27aeb088ff6d8ed1e5d5952754d68bd7'
#Debug: /Stage[main]/Gitlab::Service/File[/etc/init.d/gitlab]: The container Class[Gitlab::Service] will propagate my refresh event
#Debug: Service[gitlab](provider=upstart): Could not find gitlab.conf in /etc/init
#Debug: Service[gitlab](provider=upstart): Could not find gitlab.conf in /etc/init.d
#Debug: Service[gitlab](provider=upstart): Could not find gitlab in /etc/init
#Debug: Executing '/etc/init.d/gitlab status'
#Debug: Executing '/usr/sbin/update-rc.d -f gitlab remove'
#Debug: Executing '/usr/sbin/update-rc.d gitlab defaults'
#Notice: /Stage[main]/Gitlab::Service/Service[gitlab]/enable: enable changed 'false' to 'true'
#Debug: /Stage[main]/Gitlab::Service/Service[gitlab]: The container Class[Gitlab::Service] will propagate my refresh event
#Debug: Class[Gitlab::Service]: The container Stage[main] will propagate my refresh event
#Debug: Finishing transaction 69953226426760
#Debug: Storing state
	
}