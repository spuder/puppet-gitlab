require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect listen_addresses prameter to be present in gitlab.rb
    context 'listen_addresses is defined' do
    let(:params) {
      {
        :gitlab_branch    => '7.2.0',
        :external_url     => 'http://gitlab.example.com',
        :listen_addresses => ["0.0.0.0", "[::]"]
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/nginx\[\'listen_addresses\'\] =/)
    end
  end

# listen_addresses only works on gitlab 7.2.x
    context 'listen_addresses is less than 7.2.x' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :listen_addresses => ["0.0.0.0","[::]"],
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
      expect { subject }.to raise_error(/listen_addresses is only available in gitlab >= 7.2.0/)
    end
  end


end