require 'spec_helper'

# Gitlab 7.3 removed the redis['port'] config line, make sure it isn't enabled
#https://about.gitlab.com/2014/09/22/gitlab-7-dot-3-released-with-performance-improvements/

describe 'gitlab', :type => 'class' do


# rspec puppet can only detect failures, this only raises a warning so we cant catch it
# # Expect failure when $redis_port is defined, but using gitlab >= 7.3
#     context 'when $reids_port defined, but gitlab_branch is >=7.3' do
#     let(:params) {
#       {
#         :gitlab_branch        => '7.3.0',
#         :external_url         => 'http://gitlab.example.com',
#         :gitlab_release       => 'basic',
#         :redis_port           => '1234'
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
#       expect { subject }.to raise_error(/\$redis_port has been deprecated in gitlab 7.3, please remove/)
#     end
#   end

end