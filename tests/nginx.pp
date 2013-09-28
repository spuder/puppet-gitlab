#puppet module install jfryman/nginx

include nginx


#TODO: Figure out why this isn't working? 
file { '/etc/postfix/main.cf': 
	ensure 		=> file,
	mode		=> 0644,
	user		=> 'root',
	group		=> 'root',
	content		=> template('gitlab/postfix_main.cf').
	force		=> true,
}

