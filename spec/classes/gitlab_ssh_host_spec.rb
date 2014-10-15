require 'spec_helper'

describe 'gitlab', :type => 'class' do

# Verify gitlab_ssh_host setting is present in erb
  context 'when gitlab_ssh_host setting is set' do
    let(:params) { 
      {
        :gitlab_branch    => '7.2.0',
        :external_url  => 'http://gitlab.example.com',
        :gitlab_ssh_host => 'http://gitlab.example.com'
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
    it 'we fail' do
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/gitlab_ssh_host/)
    end
  end


# gitlab_ssh_host only works on gitlab 7.2.x
    context 'when gitlab_ssh_host is set on gitlab < 7.2' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :gitlab_ssh_host => 'http://gitlab.example.com'
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
      expect { subject }.to raise_error(/gitlab_ssh_host is only available in gitlab >= 7.2.0/)
    end
  end


end