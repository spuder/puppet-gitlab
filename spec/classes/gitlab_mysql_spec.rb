require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect db_username prameter to be present in gitlab.rb
  context 'mysql_enable is true' do
    let(:params) {
      {
        :gitlab_branch        => '7.2.0',
        :external_url         => 'http://gitlab.example.com',
        :gitlab_release       => 'enterprise',
        :gitlab_download_link => 'https://download.gitlab.com/example.rpm',
        :postgresql_enable    => false,
        :mysql_enable         => true,
        :mysql_username       => 'gitlab',
        :mysql_password       => 'super_secret',
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/db_username/)
    end
    it do
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/gitlab_rails\[\'postgres\'\] = false/)
    end
  end

  # Expect an error if both postgresql and mysql are enabled
  context 'mysql_enable and postgresql_enable are true' do
    let(:params) {
      {
          :gitlab_branch        => '7.2.0',
          :external_url         => 'http://gitlab.example.com',
          :gitlab_release       => 'enterprise',
          :gitlab_download_link => 'https://download.gitlab.com/example.rpm',
          :postgresql_enable    => true,
          :mysql_enable         => true,
          :mysql_username       => 'gitlab',
          :mysql_password       => 'super_secret',
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
      expect { subject }.to raise_error(/postgresql_enable must be false if mysql_enable is true/)
    end
  end
end
