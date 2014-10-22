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

# Expect backup_upload_connection to be present in gitlab.rb
    context 'backup_upload_connection is set' do
    let(:params) {
      {
        :gitlab_branch    => '7.4.0',
        :external_url     => 'http://gitlab.example.com',
        :backup_upload_connection => 'foobar',
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
    it do
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/backup_upload_connection/)
    end
  end

# Expect backup_upload_connection to be present in gitlab.rb
  context 'backup_upload_remote_directory is set' do
    let(:params) {
      {
        :gitlab_branch    => '7.4.0',
        :external_url     => 'http://gitlab.example.com',
        :backup_upload_remote_directory => 'foobar',
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
    it do
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/backup_upload_remote_directory/)
    end
  end


end