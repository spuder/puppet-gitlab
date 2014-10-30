require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect ldap_servers prameter to be present in gitlab.rb
  context 'ldap_servers is defined' do
    let(:params) {
      {
        :gitlab_branch    => '7.4.0',
        :gitlab_release   => 'enterprise',
        :gitlab_download_link => 'https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.4.0_omnibus.1-1.el6.x86_64.rpm',
        :external_url     => 'http://gitlab.example.com',
        :ldap_enabled     => true,
        :ldap_servers     => '[{"main"=> {"label" => "LDAP", "host" => "example.com"}}]',
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/ldap_servers/)
    end
  end

# ldap_servers only works on gitlab 7.4.x
  context 'ldap_servers is less than 7.4.x' do
    let(:params) {
      {
        :gitlab_branch    => '7.3.2',
        :external_url     => 'http://gitlab.example.com',
        :ldap_servers => '[{"main"=> {"label" => "LDAP", "host" => "example.com"}}]',
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
      expect { subject }.to raise_error(/ldap_servers is only available in gitlab >= 7.4.0/)
    end
  end


end