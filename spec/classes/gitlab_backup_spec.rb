require 'spec_helper'

describe 'gitlab', :type => 'class' do

# Expect class gitlab::backups present when $puppet_manage_backups is true
  context 'when $puppet_manage_backups is true' do
    let(:params) {
      {
        :gitlab_branch         => '7.2.0',
        :external_url          => 'http://gitlab.example.com',
        :puppet_manage_backups => true,
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
    it { should contain_class('gitlab::backup') }
  end

# Expect class gitlab::backups absent when $puppet_manage_backups is false
  context 'when $puppet_manage_backups is false' do
    let(:params) {
      {
        :gitlab_branch         => '7.0.0',
        :external_url          => 'http://gitlab.example.com',
        :puppet_manage_backups => false,
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
    it { should_not contain_class('gitlab::backup') }
  end



end