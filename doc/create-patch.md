This document outlines the steps required to make the module compabile with new releases of gitlab

First pull in the latest release from gitlab
  
  
   git checkout master
   git fetch upstream
   git merge upstream/master
   git checkout -t upstream/6-x-stable
   git push origin 6-x-stable

# Gitlab Config

    cd ~/Github/gitlabhq/config/
    git diff --no-prefix 6-2-stable:config/gitlab.yml.example 6-3-stable:config/gitlab.yml.example > /tmp/gitlab-config.diff

Duplicate the gitlab.yml.example file

    cd ~/Github/gitlab
    cat templates/gitlab.yml.6-x.stable.erb > templates/gitlab.yml.6-y-stable.erb
    Make the changes in /tmp/gitlab-config.diff to templates/gitlab.yml.6-y-stable.erb


# Unicorn Config

    cd ~/Github/gitlabhq/config/
    git diff --no-prefix 6-2-stable:config/unicorn.rb.example 6-3-stable:config/unicorn.rb.diff
    
Duplicate the unicorn.rb.example file

    cd ~/Github/gitlab
    cat templates/unicorn.rb.6-x.stable.erb > templates/unicorn.rb.6-y-stable.erb
    Make the changes in /tmp/unicorn.rb.diff to templates/unicorn.rb.6-y-stable.erb

# Init Script

    cd ~/Github/gitlabhq/
    git diff --no-prefix 6-2-stable:lib/support/init.d/gitlab 6-3-stable:lib/support/init.d/gitlab > /tmp/gitlab-init.diff

Duplicate the init script

    cd ~/Github/gitlab
    cat templates/init.6-x.stable.erb > templates/init.rb.6-y-stable.erb
    Make the changes in /tmp/gitlab-init.diff to templates/init.6-y-stable.erb


# Resources

http://tamsler.blogspot.com/2009/02/patching-with-git-diff.html