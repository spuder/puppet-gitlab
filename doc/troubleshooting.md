This file is a work in progress

# Common Errors
================

## Error 500 
http://f.cl.ly/items/0g253M0q3W290G1T0s2y/Image%202013.10.03%208%3A35%3A15%20PM.png    
Look at /home/git/gitlab/log/production.log  


If you see the following error, then the project is public, but the user is not part of the group  

    NoMethodError (undefined method `id' for nil:NilClass):  
      app/controllers/public/projects_controller.rb:22:in `show'  

*Solution: Add user to group (with atleast reporter permission), or make project private  
*Solution2: Access the project from the dashboard  
*Solution3: Wait for gitlab 6.2 to resolve this bug

http://gitlab.somedomain/admin/groups/company


## Error 502

- Verify that you ran the precompile command 
cd /home/git/gitlab
sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production


## Push prompts for git@foo password
Check the following:  
1. Is the hostname and shortname configured correctly (gitlab.yml, /etc/hosts, ect..)  
2. Is the git config --global configured  
3. Does the .ssh folder have the correct permissions  
4. Does the user have their ssh keys saved into gitlab?   
5. Does the repo actually have a file to push? 

You will most likely need to reinstall gitlab and make sure the hostname is correct
http://stackoverflow.com/questions/18501874/gitlab-prompts-for-password-while-push-for-git-user

## welcome to nginx page, doesn't redirect to https

If you have https enabled, and you nagivate to gitlab over http, remove the 'default' config from /etc/nginx/sites-available



## Thumbnail icon won't change  
- Clear the cash in your browser  
- Run `service gitlab reload` or `service gitlab restart`  
- Verify the icons in /home/git/ exist
- Remove all logo-*.png files from /home/git/gitlab/public/assets/
- Run the following command mentioned in the upgrade guide
   
    sudo -u git -H bundle exec rake assets:clean assets:precompile cache:clear RAILS_ENV=production
    
- Restart gitlab

  
  If that still didn't work, open the develper console, and take note of the name of the file in /home/git/gitlab/public/assets/logo-white-67df65ed619f59dbc0cb6d47aac306d6.png. Replace it with the custom logo
  
  


## Logging

ngninx logs are located in the following directories: 

/var/log/nginx/access.log
/var/log/nginx/error.log
/var/log/nginx/gitlab_access.log
/var/log/nginx/gitlab_error.log

gitlab logs are located in the following locations

/home/git/gitlab/log/application.log  
/home/git/gitlab/log/production.log  
/home/git/gitlab/log/sidekiq.log  
/home/git/gitlab/log/unicorn.stderr.log  
/home/git/gitlab/log/unicorn.stdout.log


# Pitfalls

Verify that /etc/nginx/sites-available/gitlab has a wildcard infromt of the server

bad
listen 80;

good
listen *:80 default_server;


