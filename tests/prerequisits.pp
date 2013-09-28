

 
$system_packages = ['libicu-dev','python2.7','python-docutils',
                    'libxml2-dev','libxslt1-dev','python-dev',
                    'build-essential']

                          
package { $system_packages: 
  ensure => present,
}






