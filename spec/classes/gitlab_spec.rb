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

# Verify $operatingsystemmajrelease is a valid fact (not true in all version of facter)
  context 'when operatingsystemmajrelease is undefined fact' do
    let(:params) { 
      {
        :external_url  => 'http://gitlab.example.com', 
        :gitlab_branch => '7.0.0'
      }
    }
    let(:facts)  {
      {
        :puppetversion => ENV['PUPPET_VERSION'],
        :facterversion => ENV['FACTER_VERSION'],
        :operatingsystemmajrelease => ''
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/Failed to retrieve fact/)
    end
  end

# Verify $external_url contains http:// or https://
  context 'when external_url contains no http:// or https://' do
    let(:params) { 
      {
        :external_url  => 'gitlab.example.com', 
        :gitlab_branch => '7.2.0'
      }
    }
    let(:facts)  {
      {
        :puppetversion => ENV['PUPPET_VERSION'],
        :facterversion => ENV['FACTER_VERSION'],
        :osfamily               => 'RedHat',
        :operatingsystem        => 'CentOS',
        :operatingsystemrelease => '6.5',
        :operatingsystemmajrelease => '6'
      }
    }
    it 'we fail' do
      expect { subject }.to raise_error(/external_url must contain string/)
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





# Expect class gitlab::config present when $puppet_manage_config is true
    context 'when $puppet_manage_config is true' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
        :puppet_manage_config => true,
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
    it { should contain_class('gitlab::config') }
  end

# Expect class gitlab::config absent when $puppet_manage_config is false
    context 'when $puppet_manage_config is false' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
        :puppet_manage_config => false,
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
    it { should_not contain_class('gitlab::config') }
  end

# Expect class gitlab::config present when $puppet_manage_config is true
    context 'when $puppet_manage_packages is true' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
        :puppet_manage_packages => true,
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
    it { should contain_class('gitlab::packages') }
  end

# Expect class gitlab::config absent when $puppet_manage_config is false
    context 'when $puppet_manage_packages is false' do
    let(:params) {
      {
        :gitlab_branch        => '7.0.0',
        :external_url         => 'http://gitlab.example.com',
        :puppet_manage_packages => false,
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
    it { should_not contain_class('gitlab::packages') }
  end










end