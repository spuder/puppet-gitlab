This document outlines the steps required to make the module compabile with new releases of gitlab

A new version of gitlab comes out on the 22nd of each month. 


#### Create variables


CURRENT_RELEASE='6-5-stable'  
NEW_RELEASE='6-6-stable'

GITLAB_LOCATION=~/Code/gitlabhq  
PUPPET_LOCATION=~/Code/geppetto/puppet-gitlab



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
    #git checkout dev
    #git pull -u origin dev

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


    Verify $PUPPET_LOCATION/templates/$NEW_RELEASE/gitlab.yml.x file downloaded properly

    Replace all variables in the gitlab config file with the ones listed in /tmp/gitlab-config-previous.diff

        cat /tmp/gitlab-config-previous.diff

    Make any other adjustments found in /tmp/gitlab-config.diff

        cat /tmp/gitlab-config.diff


# Unicorn Config
# ==============

        cd $GITLAB_LOCATION
        git diff --no-prefix $CURRENT_RELEASE:config/unicorn.rb.example $NEW_RELEASE:config/unicorn.rb.example > /tmp/unicorn-config.diff

        wget https://raw.github.com/gitlabhq/gitlabhq/$NEW_RELEASE/config/unicorn.rb.example -O $PUPPET_LOCATION/templates/unicorn.rb.$NEW_RELEASE.erb

        cat $PUPPET_LOCATION/templates/unicorn.rb.$CURRENT_RELEASE.erb | grep '<%' > /tmp/unicorn-config-previous.diff
    
    Verify $PUPPET_LOCATION/templates/$NEW_RELEASE unicorn.rb file downloaded properly

    Replace all variables in the unicorn config file with the ones listed in /tmp/unicorn-config-previous.diff 

        cat /tmp/unicorn-config-previous.diff

    Make any other adjustments found in /tmp/unicorn-config-previous.diff (such as comments)

    Optionally make sure there were no huge changes
    
        git diff --no-prefix $CURRENT_RELEASE:config/unicorn.rb.example $$NEW_RELEASE:config/unicorn.rb.example > /tmp/unicorn.diff

        cat /tmp/unicorn.diff

# Init Script
# ===========

        wget https://raw.github.com/gitlabhq/gitlabhq/$NEW_RELEASE/lib/support/init.d/gitlab -O $PUPPET_LOCATION/templates/init.$NEW_RELEASE.erb
    
    Verify $PUPPET_LOCATION/templates/init.$NEW_RELEASE.erb file downloaded properly

    Create diff of changes between previous init script and new init script
    
        cat $PUPPET_LOCATION/templates/init.$CURRENT_RELEASE.erb | grep '<%' > /tmp/init-previous-variables.txt
    
    
    Replace every line in the new init script with the line mentioned in /tmp/init-previous-variables.txt 
    
        cat /tmp/init-previous-variabes.txt 


    Optionally make sure there were no huge changes
    
        git diff --no-prefix $CURRENT_RELEASE:lib/support/init.d/gitlab $NEW_RELEASE:lib/support/init.d/gitlab > /tmp/init.diff
    
        cat /tmp/init.diff


# Nginx Config
# ============

        cd $GITLAB_LOCATION
        git diff --no-prefix $CURRENT_RELEASE:lib/support/nginx/gitlab $NEW_RELEASE:lib/support/nginx/gitlab > /tmp/nginx-config.diff

    The nginx config contains a lot of if/else logic
    Manually compare any differences and save them to $CURRENT_RELEASE:lib/support/nginx/gitlab

        cat /tmp/nginx-config.diff

    Shortcut to open the nginx config in sublime text on mac 
    
        open -f -a /Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text



# Configuration Files
# ===================


Look at the upgrade documentation to see if there are any other major changes

https://github.com/gitlabhq/gitlabhq/tree/master/doc/update


Update the following files to the latest version '6-x-stable' and latest gitlab shell branch

    /tests/init.pp
    /manifests/params.pp
    README.md

Update the module version

    vim Modulefile



# Test
# ====


Test the new config with vagrant

    vagrant up
    puppet apply /vagrant/tests/init.pp


# Resources

http://tamsler.blogspot.com/2009/02/patching-with-git-diff.html