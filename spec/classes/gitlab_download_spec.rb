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
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/gitlab_release can only be 'basic', 'enterprise' or undef. Found:/)
    end
  end

# Exepct error when gitlab_download_link has invalid url
  context 'gitlab_download_link is invalid' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
        :gitlab_download_link => 'https://downloads-packages.s3.amazonaws.com/centos-6.5/gitlab-7.4.3_omnibus.1-1.el6.x86_64.bad',
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
      expect { subject }.to raise_error(Puppet::Error, /gitlab_download_link must end in .rpm or .deb/)
    end
  end

# Exepct error when not not running cent 5,6,7
  context 'gitlab_download_link is invalid' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '0',
      }
    }
    it do
      expect { subject }.to raise_error(Puppet::Error, /Can not determine CentOS major version/)
    end
  end
end