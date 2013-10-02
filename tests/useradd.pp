
class userTest {
	user {'bar':
	ensure => present, 
	name	=> 'bar',
	shell	=> '/bin/false',
	home	=> '/home/bar',
	system	=> true,
	managehome	=> true,
	comment	=> 'Gitlab',

	}

}

include userTest
