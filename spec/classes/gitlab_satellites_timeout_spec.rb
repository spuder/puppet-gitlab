require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect satellite_timeout prameter to be present in gitlab.rb
  context 'satellites_timeout is true' do
    let(:params) {
      {
        :gitlab_branch    => '7.2.0',
        :external_url     => 'http://gitlab.example.com',
        :satellites_timeout   => 60,
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5',
      }
    }
    it do
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/satellites_timeout/)
    end
  end


end