require 'spec_helper'

describe 'gitlab', :type => 'class' do

  context 'on unsupported distributions' do
    let(:params) { { :external_url  => 'http://gitlab.example.com', :gitlab_branch => '7.0.0'} }
    let(:facts)  { { :osfamily      => 'Unsupported' }}
    let(:facts)  { { :puppetversion => '3.1.0', :facterversion => '1.8.0'} }

    it 'we fail' do
      # expect { subject }.to raise_error(/Only RedHat and Debian os families are supported/)
      expect { subject }.to raise_error(/Only Centos, Ubuntu and Debian presently supported/)
    end
  end

  context 'failure to add $gitlab_branch' do
    let(:params) { { :external_url  => 'http://gitlab.example.com'} }
    let(:facts)  { { :puppetversion => '3.1.0', :facterversion => '1.8.0'} }

    it 'we fail' do
      # expect { subject }.to raise_error(/Only RedHat and Debian os families are supported/)
      expect { subject }.to raise_error(/gitlab_branch parameter required/)
    end
  end

  context 'failure to add $external_url' do
    let(:params) { { :gitlab_branch => '7.0.0'} }
    let(:facts)  { { :puppetversion => '3.1.0', :facterversion => '1.8.0'} }

    it 'we fail' do
      # expect { subject }.to raise_error(/Only RedHat and Debian os families are supported/)
      expect { subject }.to raise_error(/external_url parameter required/)
    end
  end

  # context "with external_url => foo" do
  #   let(:params) { { :external_url => 'http://gitlab.example.com', :gitlab_branch => '7.0.0'} }
  #   let(:facts) { { :osfamily => 'Debian', :puppetversion => '3.1.0', :facterversion => '1.8.0'} }
  #   it do
  #     should contain_package('gitlab')
  #   end
  # end


end