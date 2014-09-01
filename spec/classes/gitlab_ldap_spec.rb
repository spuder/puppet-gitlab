require 'spec_helper'

describe 'gitlab', :type => 'class' do

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab < 7.1.0
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch      => '7.0.0',
        :external_url       => 'http://gitlab.example.com',
        :gitlab_release     => 'enterprise',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in gitlab 7.1.0 or greater/)
    end
  end

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab basic
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch      => '7.1.0',
        :external_url       => 'http://gitlab.example.com',
        :gitlab_release     => 'basic',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in enterprise edtition, gitlab_release is/)
    end
  end

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab with undef
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch      => '7.1.0',
        :external_url       => 'http://gitlab.example.com',
        :gitlab_release     => 'undef',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in enterprise edtition, gitlab_release is/)
    end
  end

# Expect failure when user sets ldap_admin_group but running gitlab basic
    context 'when $ldap_admin_group is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :gitlab_release   => 'basic',
        :ldap_admin_group => 'GitLab administrators',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_admin_group is only available in enterprise edtition, gitlab_release is/)
    end
  end

# Expect failure when user sets ldap_admin_group but running gitlab with undef
    context 'when $ldap_admin_group is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :gitlab_release   => 'undef',
        :ldap_admin_group => 'GitLab administrators',
      }
    }
    let(:facts) {
      {
        :puppetversion          => ENV['PUPPET_VERSION'], 
        :facterversion          => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_admin_group is only available in enterprise edtition, gitlab_release is/)
    end
  end

end