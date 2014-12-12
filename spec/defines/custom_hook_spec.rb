require 'spec_helper'

describe 'gitlab::custom_hook', :type => 'define' do
  let(:facts) {
    {
      :puppetversion          => ENV['PUPPET_VERSION'],
      :facterversion          => ENV['FACTER_VERSION'],
      :osfamily               => 'RedHat',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '6.5',
    }
  }

  context 'when neither $content and $source are defined' do
    let(:title) { 'my_custom_hook' }
    let(:params) {
      {
          :namespace      => 'my_group',
          :project        => 'my_project',
          :type           => 'pre-receive',
      }
    }

    it do
      expect { subject }.to raise_error(/gitlab::custom_hook resource must specify either content or source/)
    end
  end

  context 'when $content and $source are defined' do
    let(:title) { 'my_custom_hook' }
    let(:params) {
      {
          :namespace      => 'my_group',
          :project        => 'my_project',
          :type           => 'pre-receive',
          :content        => '#!/bin/bash',
          :source         => 'puppet:///modules/my_module/pre-receive',
      }
    }

    it do
      expect { subject }.to raise_error(/gitlab::custom_hook resource must specify either content or source, but not both/)
    end
  end

  context 'when $source is invalid' do
    let(:title) { 'my_custom_hook' }
    let(:params) {
      {
          :namespace      => 'my_group',
          :project        => 'my_project',
          :type           => 'pre-receive',
          :source         => 'invalid_source_string',
      }
    }

    it do
      expect { subject }.to raise_error(/"invalid_source_string" does not match/)
    end
  end

  context 'when $type is invalid' do
    let(:title) { 'my_custom_hook' }
    let(:params) {
      {
          :namespace      => 'my_group',
          :project        => 'my_project',
          :type           => 'receive',
          :source         => 'puppet:///modules/my_module/pre-receive',
      }
    }

    it do
      expect { subject }.to raise_error(/"receive" does not match/)
    end
  end

  context 'when $type is valid' do
    context 'pre-receive' do
      let(:title) { 'my_custom_hook' }
      let(:params) {
        {
            :namespace      => 'my_group',
            :project        => 'my_project',
            :type           => 'pre-receive',
            :source         => 'puppet:///modules/my_module/pre-receive',
        }
      }

      it { expect { subject }.not_to raise_error }
    end

    context 'post-receive' do
      let(:title) { 'my_custom_hook' }
      let(:params) {
        {
            :namespace      => 'my_group',
            :project        => 'my_project',
            :type           => 'post-receive',
            :source         => 'puppet:///modules/my_module/post-receive',
        }
      }

      it { expect { subject }.not_to raise_error }
    end

    context 'update' do
      let(:title) { 'my_custom_hook' }
      let(:params) {
        {
            :namespace      => 'my_group',
            :project        => 'my_project',
            :type           => 'update',
            :source         => 'puppet:///modules/my_module/update',
        }
      }

      it { expect { subject }.not_to raise_error }
    end
  end

  context 'when valid' do
    context '$source' do
      let(:title) { 'my_custom_hook' }
      let(:params) {
        {
            :namespace      => 'my_group',
            :project        => 'my_project',
            :type           => 'pre-receive',
            :source         => 'puppet:///modules/my_module/pre-receive',
        }
      }

      it do
        should contain_file('/var/opt/gitlab/git-data/repositories/my_group/my_project.git/custom_hooks/pre-receive')
      end
    end

    context '$content' do
      let(:title) { 'my_custom_hook' }
      let(:params) {
        {
            :namespace      => 'my_group',
            :project        => 'my_project',
            :type           => 'post-receive',
            :content        => '#!/bin/bash'
        }
      }

      it do
        should contain_file('/var/opt/gitlab/git-data/repositories/my_group/my_project.git/custom_hooks/post-receive')
          .with_content('#!/bin/bash')
      end
    end
  end
end
