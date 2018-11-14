# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :deploy_to, '/var/www/jobbier/staging'
set :branch, ENV['branch'] || 'develop'
set :rails_env, 'staging'

