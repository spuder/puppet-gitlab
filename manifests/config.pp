# init -> packages -> user -> setup -> install -> config -> service
class gitlab::config inherits gitlab {

  # All file resource declarations should be executed as git:git
  File {
    owner   =>  "${gitlab::git_user}",
    group   =>  'git',
  }


# Gitlab CONFIG
##############
 
  # Create log directory
  file { "${gitlab::git_home}/gitlab/log":
    ensure  =>  directory,
    mode    =>  '0755',
  }

  # Create tmp directory
  file { "${gitlab::git_home}/gitlab/tmp":
    ensure  =>  directory,
    mode    =>  '0755',
  }

  # Create pids directory
  file { "${gitlab::git_home}/gitlab/tmp/pids" :
    ensure  =>  directory,
    mode    =>  '0755',
  }

  # Create socket directory
  file { "${gitlab::git_home}/gitlab/tmp/sockets" :
    ensure  =>  directory,
    mode    =>  '0755',
  }

  # Create satellites directory
  file { "${gitlab::git_home}/gitlab-satellites":
    ensure  =>  directory,
    mode    =>  '0750',
  }

  # Create public/uploads directory otherwise backups will fail
  file { "${gitlab::git_home}/gitlab/public/uploads":
    ensure  =>  directory,
    mode    =>  '0755',
  }
  
# Backup CONFIG
##############
 
  # Ensure /home/git/gitlab/tmp/backups is owned by git user
  file { "${gitlab::git_home}/gitlab/${gitlab::backup_path}":
    ensure  =>  directory,
    owner   =>  'git',
    group   =>  'git',
    mode    =>  '0755', 
    recurse =>  true,
  }
  
  # Execute rake backup every night at 2 am
  cron { logrotate:
    command => "cd /home/git/gitlab && PATH=/usr/local/bin:/usr/bin:/bin bundle exec rake gitlab:backup:create RAILS_ENV=production",
    user    => git,
    hour    => 2,
    minute  => 0,
    require => File["${gitlab::git_home}/gitlab/${gitlab::backup_path}"],
  }


# NGINX CONFIG
#############

  # Create nginx sites-available directory
  file { '/etc/nginx/sites-available':
    ensure  =>  directory,
    owner   =>  'root',
    group   =>  'root',
  }

  # Create nginx sites-enabled directory
  file { '/etc/nginx/sites-enabled':
    ensure  =>  directory,
    owner   =>  'root',
    group   =>  'root',
  }

  # Copy nginx config to sites-available
  file { '/etc/nginx/sites-available/gitlab':
    ensure  =>  file,
    content =>  template('gitlab/nginx-gitlab.conf.erb'),
    mode    =>  '0644',
    owner   =>  'root',
    group   =>  'root',
  }

  # Create symbolic link
  file  { '/etc/nginx/sites-enabled/gitlab':
    ensure  =>  link,
    target  =>  '/etc/nginx/sites-available/gitlab',
    owner   =>  'root',
    group   =>  'root',
  }
  
  # Create symbolic link
  file  { '/etc/nginx/sites-enabled/default':
    ensure  =>  absent,
  }


# Gitlab-shell CONFIG
####################
  
  # Verify .ssh directory exists
  file { "${gitlab::git_home}/.ssh":
    ensure  =>  directory,
    mode    =>  '0700',    
  }
  
  # Verify authorized keys file exists
  file  { "${gitlab::git_home}/authorized_keys":
    ensure  =>  present,
    mode    =>  '0600',
  }


  # Show error when users forget to add key
  file  { "${gitlab::git_home}/ssh-banner.txt":
    ensure  =>  file,
    source  =>  'puppet:///modules/gitlab/ssh-banner.txt',
    mode    =>  '0755',
  }
  

# Logrotate CONFIG
#################

  # Setup logrotate config file
  file { '/etc/logrotate.d/gitlab':
    ensure  =>  present,
    content =>  template('gitlab/logrotate.erb'),
    mode    =>  '0644',
    owner   =>  'root',
    group   =>  'root',
  }


# Git CONFIG
###########

  # Sets sudo -u git -H git config --global user.name, user.email, autocrlf = input
  file { "${gitlab::git_home}/.gitconfig":
    ensure  =>  file,
    content =>  template('gitlab/gitconfig.erb'),
    mode    =>  '0644',
    owner   =>  "${gitlab::git_user}",
  }

# Icon Branding
###########

  # Thumbnail logo white default
  file{"${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-white.png":
    source  =>  'puppet:///modules/gitlab/gitlab-logo-white.png.erb',
    owner   =>  "${gitlab::git_user}",
    group   =>  'git',
    mode    =>  '0644',
    backup  =>  false,
  }

  # Thumbnail logo black default
  file{"${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-black.png":
    source  =>  'puppet:///modules/gitlab/gitlab-logo-black.png.erb',
    owner   =>  "${gitlab::git_user}",
    group   =>  'git',
    mode    =>  '0644',
    backup  =>  false,
  }

  # Overwrite gitlab icons with custom icons
  # The origional icon is left intact and a symbolic link is used to point to logo-white.png
  case "${gitlab::use_custom_thumbnail}" {

      'true': {

        # Set the thumbnails  to the custom icons in the gitlab/files directory
        file{ "${gitlab::git_home}/gitlab/app/assets/images/logo-white.png":
          ensure  =>  link,
          target  =>  "${gitlab::git_home}/company-logo-white.png",
          backup  =>  false,
          owner   =>  "${gitlab::git_user}",
          group   =>  'git',
          mode    =>  '0644',
          require =>  [
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-white.png"],
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-black.png"],
                      ],
        }
        file{ "${gitlab::git_home}/gitlab/app/assets/images/logo-black.png":
          ensure  =>  link,
          target  =>  "${gitlab::git_home}/company-logo-black.png",
          backup  =>  false,
          owner   =>  "${gitlab::git_user}",
          group   =>  'git',
          mode    =>  '0644',
          require =>  [
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-white.png"],
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-black.png"],
                      ],
        }

      }# end true

      'false':  {

        # Set the thumbnails to the default desert fox icon
        file{ "${gitlab::git_home}/gitlab/app/assets/images/logo-white.png":
          ensure  =>  link,
          target  =>  "${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-white.png",
          backup  =>  false,
          owner   =>  "${gitlab::git_user}",
          group   =>  'git',
          mode    =>  '0644',
          require =>  [
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-white.png"],
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-black.png"],
                      ],
        }
        file{ "${gitlab::git_home}/gitlab/app/assets/images/logo-black.png":
          ensure  =>  link,
          target  =>  "${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-black.png",
          backup  =>  false,
          owner   =>  "${gitlab::git_user}",
          group   =>  'git',
          mode    =>  '0644',
          require =>  [
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-white.png"],
                  File["${gitlab::git_home}/gitlab/app/assets/images/gitlab-logo-black.png"],
                      ],
        }
      }# end false

      default:  {
        fail("use_custom_thumbnail was set to ${gitlab::use_custom_thumbnail} which is neither false nor true")
      }

  }# end case $use_custom_thumbnail


}# end config.pp
