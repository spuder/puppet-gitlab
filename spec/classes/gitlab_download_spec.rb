require 'spec_helper'

describe 'gitlab', :type => 'class' do

## 6 different combinations of gitlab_download_link and gitlab_release

# Expect failure when gitlab_download_link is provided, but gitlab_release is undefined
    context 'when $gitlab_download_link is provided, but gitlab_release is undef' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
        :gitlab_download_link => 'https://foo.example.com',
        :gitlab_release       => 'undef',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5',
        :operatingsystemmajrelease => '6'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/gitlab_release can only be 'basic', 'enterprise' or undef. Found:/)
    end
  end

# Expect failure when gitlab_download_link is not set, and gitlab_release is enterprise
    context 'when $gitlab_download_link is provided, but gitlab_release is undef' do
    let(:params) {
      {
        :gitlab_branch  => '7.0.0',
        :external_url   => 'http://gitlab.example.com',
        :gitlab_release => 'enterprise',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5',
        :operatingsystemmajrelease => '6'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/You must specify \$gitlab_download_link when \$gitlab_release is set to 'enterprise'/)
    end
  end

# Expect failure when gitlab_download_link is not set, and gitlab_release is undefined
    context 'when $gitlab_download_link is provided, but gitlab_release is undef' do
    let(:params) {
      {
        :gitlab_branch  => '7.0.0',
        :external_url   => 'http://gitlab.example.com',
        :gitlab_release => 'undef',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5',
        :operatingsystemmajrelease => '6'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/gitlab_release can only be 'basic', 'enterprise' or undef. Found:/)
    end
  end

end