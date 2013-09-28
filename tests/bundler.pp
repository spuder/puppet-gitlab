

package { 'bundler':
    ensure    => installed,
    provider  => gem,
    
    
  }
  
  #To test, run which bundle or bundle exec