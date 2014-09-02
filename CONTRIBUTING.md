Pull requests of all kinds are encouraged


## Average Joe Pull Request Procedure:

- Fork project
- Write code
- Create merge request

---

## Rockstar Pull Request Procedure:


- Fork project
- Create github issue describing problem / improvement
- Create branch (e.g `git checkout -b issue42` )
- Add spec tests to `spec/classes/gitlab_spec.rb`   
Additional information [can be found here](http://puppetlabs.com/blog/the-next-generation-of-puppet-module-testing)

 ```gem install puppetlabs_spec_helper```
    
- Run rake tests

    ```
    export PUPPET_VERSION=$(facter puppetversion)  
    export FACTER_VERSION=$(facter facterversion)
    rake spec
    ```
    
- If tests pass, create merge request

--- 

## OCD

If you have OCD, and you modify the erb template, the init.pp or the params.pp, try and keep them in the same order and with the same amount of spacing between lines as the official gitlab config files. 

[gitlab.yml.erb](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/templates/default/gitlab.yml.erb)  

[default.rb](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/attributes/default.rb)
