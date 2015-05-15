source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 2.7']
gem 'puppet', puppetversion

group :development, :test do
  gem 'puppetlabs_spec_helper', '>= 0.1.0'
  gem 'puppet-lint',            :require => false
  gem 'rubocop',                :require => false
end
