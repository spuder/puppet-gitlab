##Pull requests of all kinds are encouraged



### Average Joe Pull Request Procedure:

- Fork project
- Write code
- Create merge request

---

### Rockstar Pull Request Procedure:


- Fork project
- Create github issue describing problem / improvement
- Create branch (e.g `git checkout -b issue42` )
- Add spec tests to `spec/classes/gitlab_spec.rb`   
Additional information [can be found here](http://puppetlabs.com/blog/the-next-generation-of-puppet-module-testing)
- Run rake tests

    ```
    export PUPPET_VERSION=$(facter puppetversion)  
    export FACTER_VERSION=$(facter facterversion)
    rake spec
    ```
    
- If tests pass, create merge request