This document is a work in progress. It likely contains omissions. 

## Upgrading gitlab

New versions are released on the 22 of each month. 
See the upgrade documentation here https://github.com/gitlabhq/gitlabhq/tree/master/doc/update



# Upgrade


Upgrade the gitlab module to the latest version

    puppet module upgrade spuder-gitlab


Stop the puppet service to prevent it from accidentially overwriting anything

    service puppet stop

Follow the install guide until you reach the step to update your config files. 
Instead of manually updating the config files, change the puppet git_branch parameter to the new version of gitlab

     gitlab_branch          => '6-2-stable',
     gitlabshell_branch		=> 'v1.7.9',


Do not manually update the init script, it will be updated at the next puppet run

Do not manually restart gitlab or nginx, they will automatically be started at the next puppet run

Check the application status

    cd /home/git/gitlab
    sudo -u git -H bundle exec rake gitlab:env:info RAILS_ENV=production
    sudo -u git -H bundle exec rake gitlab:check RAILS_ENV=production


Execute a puppet apply with the --noop flag

If all looks well, run the puppet apply again without the --noop flag


#Post upgrade

- Verify the ssl certificate permissions
- Verify the custom thumbnail icons permissions




#Pitfalls


##Problem: You are unable to switch git branches, verify that the working directory is clean###

Solution:  
Make sure to run a git status after switching branches**
http://stackoverflow.com/questions/19070744/upgrading-gitlab-gives-following-error-dont-know-how-to-build-task-migrate-ii/19070762#19070762


##Problem: You get an error that a file isn't found when trying to run puppet##

    Error: Could not retrieve catalog from remote server: Error 400 on SERVER: Could not find template 'gitlab/gitlab.yml.6-2-stable.erb' at /etc/puppet/modules/gitlab/manifests/setup.pp:63 on node gitlab.microsoft.com

Solution:  
Try uninstalling and reinstalling the gitlab module. Puppet module upgrade is know to not always be reliable


##Problem: Thumbnail icon is not updated

Solution:
Verify that the icons are named /home/git/company-logo-black.png and /home/git/company-logo-white.png and that the symbolic link looks like the following:

lrwxrwxrwx 1 git git    32 Oct 26 01:28 logo-black.png -> /home/git/company-logo-black.png
lrwxrwxrwx 1 git git    32 Oct 26 01:28 logo-white.png -> /home/git/company-logo-white.png


Compare the md5sum of the icons in /home/git with the icons in /home/git/gitlab/app/assets/images/gitlab-logo-black.png ect..
Restart nignx, gitlab and your web browser

Try disabling sendfile in the nginx config
http://stackoverflow.com/questions/6236078/how-to-clear-the-cache-of-nginx

Wait a few days. 
On more tha one occastion, even after performing all above steps, the thumbnail icon was still incorrect. 
The problem magically fixed itself after a few days. 