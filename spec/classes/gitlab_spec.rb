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
      }
    }
    it { should_not contain_class('gitlab::packages') }
  end

# Expect error when runnong on cent 5
  context 'when centos is 5' do
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
        :operatingsystemrelease => '5.5',
      }
    }
    it do
      expect { subject }.to raise_error(/Only CentOS 6 and 7 are presently supported, found:/)
    end
  end

# Expect gitlab_restricted_visibility_levels parameter to be present in gitlab.rb
    context 'gitlab_restricted_visibility_levels is true' do
    let(:params) {
      {
        :gitlab_branch    => '7.4.3',
        :external_url     => 'http://gitlab.example.com',
        :gitlab_restricted_visibility_levels => ['public','internal'],
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/gitlab_restricted_visibility_levels/)
    end
  end

end