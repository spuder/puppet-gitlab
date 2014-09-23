require 'spec_helper'

describe 'gitlab', :type => 'class' do
# Expect high_availability prameter to be present in gitlab.rb
    context 'high_availibility is true' do
    let(:params) {
      {
        :gitlab_branch    => '7.2.0',
        :external_url     => 'http://gitlab.example.com',
        :high_availability_mountpoint => '/tmp',
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
      should contain_file('/etc/gitlab/gitlab.rb').with_content(/high_availability/)
    end
  end

# high_availability only works on gitlab 7.2.x
    context 'high_availibility is less than 7.2.x' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :high_availability_mountpoint => '/tmp',
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
      expect { subject }.to raise_error(/high_availability_mountpoint is only available in gitlab >= 7.2.0/)
    end
  end

end