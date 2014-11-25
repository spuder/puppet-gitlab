require 'spec_helper'

describe 'gitlab', :type => 'class' do
  let(:facts) {
    {
      :puppetversion          => ENV['PUPPET_VERSION'],
      :facterversion          => ENV['FACTER_VERSION'],
      :osfamily               => 'RedHat',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '6.5',
    }
  }

# Expect an error if db_ params exist but mysql_enable false or postg true
  context 'db parameters are set' do
    context 'postgresql_enable is true' do
      let(:params) {
        {
          :gitlab_branch        => '7.2.0',
          :external_url         => 'http://gitlab.example.com',
          :postgresql_enable    => true,
          :db_adapter           => 'mysql2',
        }
      }

      it do
        expect { subject }.to raise_error(/db_adapter, db_encoding, db_database, db_pool, db_username, db_password, db_host, and db_socket cannot be set unless postgres_enable is false or mysql_enable is true/)
      end
    end

    context 'postgresql_enable is undef' do
      let(:params) {
        {
          :gitlab_branch        => '7.2.0',
          :external_url         => 'http://gitlab.example.com',
          :db_adapter           => 'mysql2',
        }
      }

      it do
        expect { subject }.to raise_error(/db_adapter, db_encoding, db_database, db_pool, db_username, db_password, db_host, and db_socket cannot be set unless postgres_enable is false or mysql_enable is true/)
      end
    end

    context 'mysql_enable is false and postgres_enable if false' do
      let(:params) {
        {
          :gitlab_branch        => '7.2.0',
          :external_url         => 'http://gitlab.example.com',
          :mysql_enable         => false,
          :postgresql_enable    => false,
          :db_adapter           => 'mysql2',
        }
      }

      it do
        expect { subject }.to raise_error(/db_adapter, db_encoding, db_database, db_pool, db_username, db_password, db_host, and db_socket cannot be set unless postgres_enable is false or mysql_enable is true/)
      end
    end
  end
# Expect an error if postgresql_port is set and db_port doesn't match
  context 'postgresql_port and db_port do not match' do
    let(:params) {
      {
        :gitlab_branch        => '7.2.0',
        :external_url         => 'http://gitlab.example.com',
        :gitlab_release       => 'enterprise',
        :gitlab_download_link => 'https://download.gitlab.com/example.rpm',
        :postgresql_port      => 3306,
      }
    }

    it do
      expect { subject }.to raise_error(/if postgresql_port is specified, db_port must match/)
    end
  end

# Expect db_username prameter to be present in gitlab.rb
  context 'mysql_enable is true' do
    context 'required parameters are set' do
      let(:params) {
        {
          :gitlab_branch        => '7.2.0',
          :external_url         => 'http://gitlab.example.com',
          :gitlab_release       => 'enterprise',
          :gitlab_download_link => 'https://download.gitlab.com/example.rpm',
          :postgresql_enable    => false,
          :mysql_enable         => true,
          :db_adapter           => 'mysql2',
          :db_username          => 'gitlab',
          :db_password          => 'super_secret',
        }
      }

      it do
        should contain_file('/etc/gitlab/gitlab.rb').with_content(/db_username/)
      end
      it do
        should contain_file('/etc/gitlab/gitlab.rb').with_content(/gitlab_rails\[\'db_adapter\'\] = 'mysql2'/)
      end
      it do
        should contain_file('/etc/gitlab/gitlab.rb').with_content(/postgresql\[\'enable\'\] = false/)
      end
    end

    context 'db_adapter is not set to mysql2' do
      let(:params) {
        {
          :gitlab_branch        => '7.2.0',
          :external_url         => 'http://gitlab.example.com',
          :gitlab_release       => 'enterprise',
          :gitlab_download_link => 'https://download.gitlab.com/example.rpm',
          :postgresql_enable    => false,
          :mysql_enable         => true,
        }
      }

      it do
        expect { subject }.to raise_error(/db_adapter must be mysql2 if mysql_enable is true/)
      end
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
        :db_username          => 'gitlab',
        :db_password          => 'super_secret',
      }
    }
    it do
      expect { subject }.to raise_error(/postgresql_enable must be false if mysql_enable is true/)
    end
  end
end
