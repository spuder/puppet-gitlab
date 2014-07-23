require 'spec_helper'

describe 'gitlab', :type => 'class' do

# Verify Using puppet 3.0 or greater
  context 'when puppet version < 3.0' do
    let(:params) { 
      {
        :external_url  => 'http://gitlab.example.com',
        :gitlab_branch => '7.0.0'
      }
    }
    let(:facts) {
      {
        :puppetversion => '2.7.0',
        :facterversion => ENV['FACTER_VERSION']
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/Gitlab requires puppet 3.0.0 or greater/)
    end
  end

# Verify using facter 1.7 or greater
  context 'when facter version < 1.7' do
    let(:params) { 
      {
        :external_url  => 'http://gitlab.example.com', 
        :gitlab_branch => '7.0.0'
      }
    }
    let(:facts)  {
      {
        :facterversion => '1.6.0',
        :puppetversion => ENV['PUPPET_VERSION']
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/Gitlab requires facter 1.7.0 or greater/)
    end
  end

# Expect error when running on OS other than Cent or Ubuntu or Debian
  context 'on unsupported distributions' do
    let(:params) {
      {
        :external_url  => 'http://gitlab.example.com', 
        :gitlab_branch => '7.0.0'
      }
    }
    let(:facts)  {
      {
        :osfamily      => 'Unsupported',
        :puppetversion => ENV['PUPPET_VERSION'],
        :facterversion => ENV['FACTER_VERSION']
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/Only Centos, Ubuntu and Debian presently supported/)
    end
  end

# Expect error when paramter $gitlab_branch is missing
  context 'failure to add $gitlab_branch' do
    let(:params) { { :external_url  => 'http://gitlab.example.com'} }
    let(:facts)  {
      {
        :puppetversion => ENV['PUPPET_VERSION'],
        :facterversion => ENV['FACTER_VERSION']
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/gitlab_branch parameter required/)
    end
  end

# Expect error when paramter $external_url is missing
  context 'failure to add $external_url' do
    let(:params) { { :gitlab_branch => '7.0.0'} }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'],
        :facterversion => ENV['FACTER_VERSION']
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/external_url parameter required/)
    end
  end

  # context 'warning if not using Ubuntu 12.04 CentOS 6.5, Debian 7.5 ' do
  #   let(:params) { 
  #     { 
  #       :gitlab_branch => '7.0.0',
  #       :external_url  => 'http://gitlab.example.com'
  #     }
  #   }
  #   let(:facts) {
  #       {
  #       :puppetversion => ENV['PUPPET_VERSION'], 
  #       :facterversion => ENV['FACTER_VERSION'],
  #       :osfamily => 'RedHat',
  #       :operatingsystem => 'CentOS',
  #       :operatingsystemrelease => '6.4'
  #       }
  #     }
  #   it 'we fail' do
  #     # expect { subject }.to raise_error(Puppet::Warn, /is not on approved list,/)
  #     expect { should compile }.to raise_error(Puppet::Error, /is not on approved list,/)
  #   end
  # end

# Expect class gitlab::backups present when $puppet_manage_backups is true
  context 'when $puppet_manage_backups is true' do
    let(:params) {
      {
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :puppet_manage_backups => true,
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it { should contain_class('gitlab::backup') }
  end

# Expect class gitlab::backups absent when $puppet_manage_backups is false
  context 'when $puppet_manage_backups is false' do
    let(:params) {
      {
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :puppet_manage_backups => false,
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it { should_not contain_class('gitlab::backup') }
  end

# Expect class gitlab::config present when $puppet_manage_config is true
    context 'when $puppet_manage_config is true' do
    let(:params) {
      {
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :puppet_manage_config => true,
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it { should contain_class('gitlab::config') }
  end

# Expect class gitlab::config absent when $puppet_manage_config is false
    context 'when $puppet_manage_config is false' do
    let(:params) {
      {
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :puppet_manage_config => false,
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it { should_not contain_class('gitlab::config') }
  end

## 6 different combinations of gitlab_download_link and gitlab_release

# Expect failure when gitlab_download_link is provided, but gitlab_release is undefined
    context 'when $gitlab_download_link is provided, but gitlab_release is undef' do
    let(:params) {
      {
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :gitlab_download_link => 'https://foo.example.com',
        :gitlab_release => 'undef',
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
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
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :gitlab_release => 'enterprise',
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
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
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :gitlab_release => 'undef',
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/gitlab_release can only be 'basic', 'enterprise' or undef. Found:/)
    end
  end

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab < 7.1.0
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch => '7.0.0',
        :external_url  => 'http://gitlab.example.com',
        :gitlab_release => 'undef',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
      }
    }
    let(:facts) {
      {
        :puppetversion => ENV['PUPPET_VERSION'], 
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily => 'RedHat',
        :operatingsystem => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in gitlab 7.1.0 or greater/)
    end
  end




end