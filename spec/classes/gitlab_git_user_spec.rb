require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect git_username prameter to be present in gitlab.rb
    context 'git_username is defined' do
    let(:params) {
      {
        :gitlab_branch    => '7.2.0',
        :external_url     => 'http://gitlab.example.com',
        :git_username     => 'herp',
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/user\[\'username\'\] = \'herp\'/)
    end
  end

  # Expect git_username prameter to be present in gitlab.rb
    context 'git_groupname is defined' do
    let(:params) {
      {
        :gitlab_branch    => '7.2.0',
        :external_url     => 'http://gitlab.example.com',
        :git_groupname    => 'derp',
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/user\[\'group\'\] = \'derp\'/)
    end
  end

end