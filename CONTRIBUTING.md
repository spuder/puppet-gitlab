Pull requests of all kinds are encouraged

Please try and keep 1 commit / issue per merge request

## Average Joe Pull Request Procedure:

- Fork project
- Write code
- Test code

    ```
    puppet parser validate foo.pp  	
    gem install puppet-lint  
    puppet-lint --no-80chars-check --no-class_inherits_from_params_class-check --no-autoloader_layout-check manifests/*.pp 
    ```

- Create merge request


## Rockstar Pull Request Procedure:


- Fork project
- Create github issue describing problem / improvement
- Create branch (e.g `git checkout -b issue42` )  
- Write Code
- Quick tests

    ```
    puppet parser validate foo.pp  
    gem install puppet-lint  
    puppet-lint --no-80chars-check --no-class_inherits_from_params_class-check --no-autoloader_layout-check manifests/*.pp 
    ```

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


## OCD

Try and keep the order and spacing of parameters in the init.pp and params.pp the same as the official gitlab config files. 

[gitlab.yml.erb](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/templates/default/gitlab.yml.erb)  

[default.rb](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/attributes/default.rb)
