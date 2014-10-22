Pull requests of all kinds are encouraged

Please try and keep 1 commit / issue per merge request. Here is [an example commit](Here is an [example commit](https://github.com/spuder/puppet-gitlab/commit/c4fafbfe4058bf5d346a744dfbd1a9eed9791e88) which adds a new paramter to all relevant files.) to add a new parameter. 

Checkout the [README.md](https://github.com/spuder/puppet-gitlab/blob/master/README.md) for instrutions on spinning up a test vm in Vagrant. 

## Average Joe Pull Request Procedure:

- Fork project
- Write code
- Test code

    puppet parser validate foo.pp  
    gem install puppet-lint  
    puppet-lint --no-80chars-check --no-class_inherits_from_params_class-check --no-autoloader_layout-check manifests/*.pp 

- Create merge request


## Rockstar Pull Request Procedure:


- Fork project
- Create github issue describing problem / improvement
- Create branch (e.g `git checkout -b issue42` )  
- Write Code
- Quick tests


    puppet parser validate foo.pp  
    gem install puppet-lint  
    puppet-lint --no-80chars-check --no-class_inherits_from_params_class-check --no-autoloader_layout-check manifests/*.pp 


- Add spec tests to `spec/classes/gitlab_spec.rb` 
Additional information [can be found here](http://puppetlabs.com/blog/the-next-generation-of-puppet-module-testing)

```gem install puppetlabs_spec_helper```
    
- Run rake tests

    export PUPPET_VERSION=$(facter puppetversion)
    export FACTER_VERSION=$(facter facterversion)
    export STRICT_VARIABLES=yes
    rake spec

- If tests pass, create merge request


## OCD

Try and keep the order and spacing of parameters in the init.pp and params.pp the same as the official gitlab config files. 

[gitlab.yml.erb](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/templates/default/gitlab.yml.erb)  

[default.rb](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-cookbooks/gitlab/attributes/default.rb)

## Guard

A Guardfile has been provided for your convenience

    gem install guard
    gem install guard-rake

    export PUPPET_VERSION=$(facter puppetversion)  
    export FACTER_VERSION=$(facter facterversion)
    export STRICT_VARIABLES=yes
    guard

Now any changes made to manifests/*.pp will trigger the guard process to run `rake spec`
 