class { 'gitlab' : 
    git_user               => 'git',
    git_home               => '/home/git',
    git_email              => 'git@adaptivecomputing.com',
    git_comment            => 'GitLab',
#    gitlab_sources         => 'git://github.com/gitlabhq/gitlabhq.git',
    gitlab_branch          => '6-1-stable',
#    gitlabshell_sources    => 'git://github.com/gitlabhq/gitlab-shell.git',
    gitlabshell_branch     => 'v1.7.1',
    user_create_team        => false,
    }