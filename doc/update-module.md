This document outlines the steps required to make the module compabile with new releases of gitlab

A new version of gitlab comes out on the 22nd of each month. 


#### Create variables


    CURRENT_RELEASE='6-8-stable'  
    NEW_RELEASE='6-9-stable'

Set variables for the location of gitlab source code and puppet module source

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
    git pull


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

     # Optionally make sure there were no huge changes
    
     git diff --no-prefix $CURRENT_RELEASE:config/unicorn.rb.example $$NEW_RELEASE:config/unicorn.rb.example > /tmp/unicorn.diff

    cat /tmp/unicorn.diff

# Init Script
# ===========

        wget https://raw.github.com/gitlabhq/gitlabhq/$NEW_RELEASE/lib/support/init.d/gitlab -O $PUPPET_LOCATION/templates/init.$NEW_RELEASE.erb
    
Verify $PUPPET_LOCATION/templates/init.$NEW_RELEASE.erb file downloaded properly

Create diff of changes between previous init script and new init script
    
    cat $PUPPET_LOCATION/templates/init.$CURRENT_RELEASE.erb | grep '<%' > /tmp/init-previous-variables.txt
    
    
Replace every line in the new init script with the line mentioned in /tmp/init-previous-variables.txt 
    
    cat /tmp/init-previous-variables.txt 

    # Optionally make sure there were no huge changes
    
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

go to [this page](https://github.com/gitlabhq/gitlabhq/tree/master/doc/update
) and find the correct gitlab-shell version 

Set the proper gitlab-shell and gitlab-branch in the following files


    /tests/init.pp
    /manifests/params.pp
    README.md

Update the module version using semantic versioning (eg. 1.2.3)

    vim Modulefile



# Test
# ====


Test the new config with vagrant

    cd ~/Code/geppetto/puppet-gitlab
    vagrant up
    puppet apply /vagrant/tests/init.pp --debug
 
Navigate to 192.168.33.10 and https://192.168.33.10
Sign in with the following credentials  
 
 
     admin@local.host
     5iveL!fe  
     
     
Look at the admin page and verify that the version number in the bottom right is correct  
    
Optionally test any other settings (LDAP, omniauth ect..)
    
# Puppet forge
# ============

Update the CHANGELOG and push to github & the puppet forge
    


# Resources

http://tamsler.blogspot.com/2009/02/patching-with-git-diff.html