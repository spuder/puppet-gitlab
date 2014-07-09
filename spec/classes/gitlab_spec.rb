require 'spec_helper'

describe 'gitlab', :type => 'class' do

  context 'when puppet version < 3.0' do
    let(:params) { { :external_url  => 'http://gitlab.example.com', :gitlab_branch => '7.0.0'} }
    let(:facts) { { :puppetversion => '2.7.0' , :facterversion => ENV['FACTER_VERSION'] }}
    it 'we fail' do
      expect { subject }.to raise_error(/Gitlab requires puppet 3.0.0 or greater/)
    end
  end

  context 'when facter version < 1.7' do
    let(:params) { { :external_url  => 'http://gitlab.example.com', :gitlab_branch => '7.0.0'} }
    let(:facts)  { { :facterversion => '1.6.0' , :puppetversion => ENV['PUPPET_VERSION'] } }
    it 'we fail' do
      expect { subject }.to raise_error(/Gitlab requires facter 1.7.0 or greater/)
    end
  end

  context 'on unsupported distributions' do
    let(:params) { { :external_url  => 'http://gitlab.example.com', :gitlab_branch => '7.0.0'} }
    let(:facts)  { { :osfamily      => 'Unsupported', :puppetversion => ENV['PUPPET_VERSION'], :facterversion => ENV['FACTER_VERSION'] } }
    it 'we fail' do
      expect { subject }.to raise_error(/Only Centos, Ubuntu and Debian presently supported/)
    end
  end

  context 'failure to add $gitlab_branch' do
    let(:params) { { :external_url  => 'http://gitlab.example.com'} }
    let(:facts)  { { :puppetversion => ENV['PUPPET_VERSION'], :facterversion => ENV['FACTER_VERSION'] } }
    it 'we fail' do
      expect { subject }.to raise_error(/gitlab_branch parameter required/)
    end
  end

  context 'failure to add $external_url' do
    let(:params) { { :gitlab_branch => '7.0.0'} }
    let(:facts)  { { :puppetversion => ENV['PUPPET_VERSION'], :facterversion => ENV['FACTER_VERSION'] } }
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

end