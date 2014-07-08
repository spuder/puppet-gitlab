require 'spec_helper'

describe 'gitlab', :type => 'class' do



  context "with external_url => foo" do
    let(:params) { { :external_url => 'http://gitlab.example.com', :gitlab_branch => '7.0.0'} }
    let(:facts) { { :osfamily => 'Debian', :puppetversion => '3.1.0', :facterversion => '1.8.0'} }
    it do
      should contain_package('gitlab')
    end
  end


end