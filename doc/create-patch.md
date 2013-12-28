This document outlines the steps required to make the module compabile with new releases of gitlab

A new version of gitlab comes out on the 22nd of each month. 


CURRENT_RELEASE='6-3-stable'
NEW_RELEASE='6-4-stable'

GITLAB_LOCATION=~/Code/gitlabhq
PUPPET_LOCATION=~/Code/puppet-gitlab

cd $GITLAB_LOCATION
git checkout master
git pull -u origin $CURRENT_RELEASE
git checkout -b $CURRENT_RELEASE origin/$CURRENT_RELEASE
git pull -u origin $NEW_RELEASE
git checkout -b $NEW_RELEASE origin/$NEW_RELEASE
git pull

cd $PUPPET_LOCATION
git checkout master
git pull -u origin master
git checkout dev
git pull -u origin dev

#Instructions if working from a fork
  
#git checkout master
#git fetch upstream
#git merge upstream/master
#git checkout -t upstream/6-x-stable
#git push origin 6-x-stable






# Gitlab Config

    cd $GITLAB_LOCATION
    git diff --no-prefix $CURRENT_RELEASE:config/gitlab.yml.example $NEW_RELEASE:config/gitlab.yml.example > /tmp/gitlab-config.diff

Duplicate the gitlab.yml.example file

    cd $PUPPET_LOCATION
    cat templates/gitlab.yml.$CURRENT_RELEASE.erb > templates/gitlab.yml.$NEW_RELEASE.erb
    #Review the changes in /tmp/gitlab-config.diff to templates/gitlab.yml.6-y-stable.erb

# ==============================


# Unicorn Config

    cd $GITLAB_LOCATION
    git diff --no-prefix $CURRENT_RELEASE:config/unicorn.rb.example $NEW_RELEASE:config/unicorn.rb.example > /tmp/unicorn-config.diff

    
Duplicate the unicorn.rb.example file

    cd $PUPPET_LOCATION
    cat templates/unicorn.rb.$CURRENT_RELEASE.erb > templates/unicorn.rb.$NEW_RELEASE.erb
    # Make the changes in /tmp/unicorn.rb.diff to templates/unicorn.rb.$NEW_RELEASE.erb

# ==============================

# Init Script

    cd $GITLAB_LOCATION
    git diff --no-prefix $CURRENT_RELEASE:lib/support/init.d/gitlab $NEW_RELEASE:lib/support/init.d/gitlab > /tmp/gitlab-init.diff

Duplicate the init script

    cd $PUPPET_LOCATION
    cat templates/init.$CURRENT_RELEASE.erb > templates/init.$NEW_RELEASE.erb
    # Make the changes in /tmp/gitlab-init.diff to templates/init.$NEW_RELEASE.erb




# Resources

http://tamsler.blogspot.com/2009/02/patching-with-git-diff.html