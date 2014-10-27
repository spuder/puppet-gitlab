require 'spec_helper'

describe 'gitlab', :type => 'class' do

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab < 7.1.0
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch      => '7.0.0',
        :external_url       => 'http://gitlab.example.com',
        :gitlab_release     => 'enterprise',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
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
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in gitlab 7.1.0 or greater/)
    end
  end

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab basic
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch      => '7.1.0',
        :external_url       => 'http://gitlab.example.com',
        :gitlab_release     => 'basic',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
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
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in enterprise edtition, gitlab_release is/)
    end
  end

# Expect failure when user sets ldap_sync_ssh_keys but running gitlab with undef
    context 'when $ldap_sync_ssh_keys is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch      => '7.1.0',
        :external_url       => 'http://gitlab.example.com',
        :gitlab_release     => 'undef',
        :ldap_sync_ssh_keys => 'fake-ssh-key',
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
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_sync_ssh_keys is only available in enterprise edtition, gitlab_release is/)
    end
  end

# Expect failure when user sets ldap_admin_group but running gitlab basic
    context 'when $ldap_admin_group is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :gitlab_release   => 'basic',
        :ldap_admin_group => 'GitLab administrators',
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
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_admin_group is only available in enterprise edtition, gitlab_release is/)
    end
  end

# Expect failure when user sets ldap_admin_group but running gitlab with undef
    context 'when $ldap_admin_group is provided, but gitlab_branch is less than 7.1.0' do
    let(:params) {
      {
        :gitlab_branch    => '7.1.0',
        :external_url     => 'http://gitlab.example.com',
        :gitlab_release   => 'undef',
        :ldap_admin_group => 'GitLab administrators',
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
    it 'we fail' do
      expect { subject }.to raise_error(/ldap_admin_group is only available in enterprise edtition, gitlab_release is/)
    end
  end

# #######
# # 7.4
# # Gitlab revamped how ldap is configured
# # http://bit.ly/1CXbx3G
# # https://about.gitlab.com/2014/10/22/gitlab-7-4-released/
# # https://gitlab.com/gitlab-org/omnibus-gitlab/commit/cbd33aaa571c240804dde75329439fe8fd31b867?view=inline


# # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using old ldap_host' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_host        => 'example.com',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

# # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using ldap_port' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_port        => 42,
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#   # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using ldap_uid' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_uid        => 42,
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#   # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using ldap_method' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_method        => 'ssl',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#   # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using ldap_bind_dn' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_bind_dn        => 'foobar',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#     # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using ldap_password' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_password        => 'foobar',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#     # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#     context 'when gitlab 7.4 is provided, using ldap_base' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_base        => 'foobar',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#     # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#   context 'when gitlab 7.4 is provided, using ldap_group_base' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_group_base        => 'foobar',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end

#       # Expect failure when user runs gitlab 7.4 with old ldap parameter syntax
#   context 'when gitlab 7.4 is provided, using ldap_user_filter' do
#     let(:params) {
#       {
#         :gitlab_branch    => '7.4.0',
#         :external_url     => 'http://gitlab.example.com',
#         :gitlab_release   => 'basic',
#         :ldap_enabled     => true,
#         :ldap_user_filter        => 'foobar',
#       }
#     }
#     let(:facts) {
#       {
#         :puppetversion          => ENV['PUPPET_VERSION'], 
#         :facterversion          => ENV['FACTER_VERSION'],
#         :osfamily               => 'RedHat',
#         :operatingsystem        => 'CentOS',
#         :operatingsystemrelease => '6.5',
#       }
#     }
#     it 'we fail' do
#       expect { subject }.to raise_error(/Gitlab 7.4 introduced new syntax for ldap configurations/)
#     end
#   end


end
