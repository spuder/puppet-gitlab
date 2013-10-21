#This moanifest tests what happens when the git branch is updated between puppet runs. 
#Does puppet switch branches? 

class git_branch_test inherits gitlab {

  #Download gitlab source
  exec { 'download gitlab':
    command => "git clone -b ${gitlab::gitlab_branch} ${gitlab::gitlab_sources} ${gitlab::git_home}/gitlab",
    creates   => "${gitlab::git_home}/gitlab",
  }
  
}

# To test, set gitlab::git_branch to 6-0-stable
# run this manifest once (puppet apply git_branch_test --debug)
# verify that branch 6-0-stable is the branch in /home/git/gitlab
# update gitlab::git_branch to 6-1-stable
# run this module again, 
# see if /home/git/gitlab git branch has updated 