require 'spec_helper'

describe 'gitlab', :type => 'class' do

  context "On a Debian OS with no package name specified" do
    let :facts do
      {
        :osfamily => 'Debian'
      }
    end

    it {
      should contain_package('gitlab').with( { 'name' => 'gitlab' } )
    }
  end

  context "On a RedHat OS with no package name specified" do
    let :facts do
      {
        :osfamily => 'RedHat'
      }
    end

    it {
      should contain_package('gitlab').with( { 'name' => 'gitlab' } )
    }
  end

  context "On an unknown OS with no package name specified" do
    let :facts do
      {
        :osfamily => 'Darwin'
      }
    end

    it {
      expect { should raise_error(Puppet::Error) }
    }
  end

  context "With a package name specified" do
    let :params do
      {
        :package_name => 'gitlab'
      }
    end

    it {
      should contain_package('gitlab').with( { 'name' => 'gitlab' } )
    }
  end
end