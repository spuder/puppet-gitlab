#puppet module install example42/postfix

include postfix


#Don't include this because it causes duplicate declaration
#file {'/etc/postfix/main.cf':
#  ensure  => file,
#  content => template('gitlab/gitlab.nginx-gitlab.conf.erb'),
#}

