 
  #Install charlock_holmes 
  package { 'charlock_holmes':
    ensure    => '0.6.9.4',
    provider  => 'gem',
  }
  
  
  package { 'mysql2' :
    ensure    => '0.3.11',
    provider  => gem,
  }