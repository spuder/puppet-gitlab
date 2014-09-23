require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect ldap_sync_time prameter to be present in gitlab.rb
  context 'ldap_sync_time is true' do
    let(:params) {
      {
        :gitlab_branch    => '7.2.0',
        :external_url     => 'http://gitlab.example.com',
        :ldap_enabled     => true,
        :ldap_sync_time   => 3600,
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/ldap_sync_time/)
    end
  end

# ldap_sync_time only works on gitlab 7.2.x
  context 'ldap_sync_time is less than 7.2.x' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :ldap_enabled     => true,
        :ldap_sync_time   => 3600,
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
      expect { subject }.to raise_error(/ldap_sync_time is only available in gitlab >= 7.2.0/)
    end
  end

end