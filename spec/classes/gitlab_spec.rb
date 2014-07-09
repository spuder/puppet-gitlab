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
      # expect { subject }.to raise_error(/Only RedHat and Debian os families are supported/)
      expect { subject }.to raise_error(/Only Centos, Ubuntu and Debian presently supported/)
    end
  end

  context 'failure to add $gitlab_branch' do
    let(:params) { { :external_url  => 'http://gitlab.example.com'} }
    let(:facts)  { { :puppetversion => ENV['PUPPET_VERSION'], :facterversion => ENV['FACTER_VERSION'] } }
    it 'we fail' do
      # expect { subject }.to raise_error(/Only RedHat and Debian os families are supported/)
      expect { subject }.to raise_error(/gitlab_branch parameter required/)
    end
  end

  context 'failure to add $external_url' do
    let(:params) { { :gitlab_branch => '7.0.0'} }
    let(:facts)  { { :puppetversion => ENV['PUPPET_VERSION'], :facterversion => ENV['FACTER_VERSION'] } }
    it 'we fail' do
      # expect { subject }.to raise_error(/Only RedHat and Debian os families are supported/)
      expect { subject }.to raise_error(/external_url parameter required/)
    end
  end


end