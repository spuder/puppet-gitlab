▢
✔
✘

##Structure
gitlab
gitlab::params
init -> packages -> user -> setup -> install -> config -> service




##Manual Setup
Python must be 2.7
fqdn and shortname must be set


##Modules

✘ vcs_repo to pull git code -- nevermind, too complex


##Packages

✔ git ppa
✘ python 2.7 = No way to force check of specific version (enhancment request)

▢ build-essential 
▢ zlib1g-dev 
▢ libyaml-dev 
▢ libssl-dev 
▢ libgdbm-dev 
✔ libreadline-dev 
▢ libncurses5-dev 
▢ libffi-dev curl 
▢ git-core 
openssh-server 
▢ redis-server 
checkinstall 
✔ libxml2-dev 
✔libxslt1-dev 
▢ libcurl4-openssl-dev 
▢ libicu-dev



##Programs from source







##TODO

Not sure how to apply the following setting, exec? template?

# Configure Git global settings for git user, useful when editing via web
# Edit user.email according to what is set in gitlab.yml
sudo -u git -H git config --global user.name "GitLab"
sudo -u git -H git config --global user.email "gitlab@localhost"
sudo -u git -H git config --global core.autocrlf input









ruby 1.9 (through either alternatives, rvm or source)

bundler (part of the git user environment)

git user {install.pp}

