This document outlines the steps required to make the module compabile with new releases of gitlab

A new version of gitlab comes out on the 22nd of each month. 


# Check blog for new features
# ======================

https://about.gitlab.com/blog


# Add new feature
# ===============

If there is a new parameter, add it to the following files

- init.pp
- params.pp
- test/foo.pp
- spec/classes/foo.rb

Here is an [example commit](https://github.com/spuder/puppet-gitlab/commit/c4fafbfe4058bf5d346a744dfbd1a9eed9791e88) which adds a new paramter to all relevant files. 

Look at the admin page and verify that the version number in the bottom right is correct  

Optionally test any other settings (LDAP, omniauth ect..)

# Puppet forge
# ============

Update the version in the following files

- CHANGELOG.md
- metadata.json
