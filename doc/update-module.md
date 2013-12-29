This document outlines the steps required to make the module compabile with new releases of gitlab

A new version of gitlab comes out on the 22nd of each month. 


CURRENT_RELEASE='6-3-stable'
NEW_RELEASE='6-4-stable'

GITLAB_LOCATION=~/Code/gitlabhq
PUPPET_LOCATION=~/Code/puppet-gitlab



##Instructions if working from a fresh directory


    cd $GITLAB_LOCATION
    git checkout master
    git pull
    git checkout -b $CURRENT_RELEASE origin/$CURRENT_RELEASE
    git pull
    git checkout -b $NEW_RELEASE origin/$NEW_RELEASE
    git pull

    cd $PUPPET_LOCATION
    git checkout master
    git pull -u origin master
    git checkout dev
    git pull -u origin dev

##Instructions if working from a fork
  
    #git checkout master
    #git fetch upstream
    #git merge upstream/master
    #git checkout -t upstream/6-x-stable
    #git push origin 6-x-stable






# Gitlab Config
# =============

    cd $GITLAB_LOCATION
    git diff --no-prefix $CURRENT_RELEASE:config/gitlab.yml.example $NEW_RELEASE:config/gitlab.yml.example > /tmp/gitlab-config.diff

    wget https://raw.github.com/gitlabhq/gitlabhq/$NEW_RELEASE/config/gitlab.yml.example -O $PUPPET_LOCATION/templates/gitlab.yml.$NEW_RELEASE.erb

    cat $PUPPET_LOCATION/templates/gitlab.yml.$CURRENT_RELEASE.erb | grep '<%' > /tmp/gitlab-config-previous.diff


    # Verify $PUPPET_LOCATION/templates/$NEW_RELEASE gitlab config file downloaded properly

    # Replace all variables in the gitlab config file with the ones listed in /tmp/$NEW_RELEASE.erb 

    # Make any other adjustments found in /tmp/gitlab-config.diff




# Unicorn Config
# ==============

    cd $GITLAB_LOCATION
    git diff --no-prefix $CURRENT_RELEASE:config/unicorn.rb.example $NEW_RELEASE:config/unicorn.rb.example > /tmp/unicorn-config.diff

    wget https://raw.github.com/gitlabhq/gitlabhq/$NEW_RELEASE/config/unicorn.rb.example -O $PUPPET_LOCATION/templates/unicorn.rb.$NEW_RELEASE.erb

    cat $PUPPET_LOCATION/templates/unicorn.rb.$NEW_RELEASE.erb | grep '<%' > /tmp/unicorn-config-previous.diff

# Init Script
# ===========

    wget https://raw.github.com/gitlabhq/gitlabhq/$NEW_RELEASE/lib/support/init.d/gitlab -O $PUPPET_LOCATION/templates/init.$NEW_RELEASE.erb


# Nginx Config
# ============

    cd $GITLAB_LOCATION
    git diff --no-prefix $CURRENT_RELEASE:lib/support/nginx/gitlab $NEW_RELEASE:lib/support/nginx/gitlab > /tmp/nginx-config.diff

    # The nginx config contains a lot of if/else logic
    # Manually compare any differences


# Resources

http://tamsler.blogspot.com/2009/02/patching-with-git-diff.html