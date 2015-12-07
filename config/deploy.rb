# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'depot'
set :repo_url, "ssh://andrew@www.mydepot.com/~/git/depot.git"


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'
set :deploy_to, "/home/andrew/Sites/depot"
set :rails_env, 'production'
#set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}


# files we want symlinking to specific entries in shared.
set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{shared}

# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
#role :app, "andrew@www.mydepot.com"
#role :web, "andrew@www.mydepot.com"
#role :db,  "andrew@www.mydepot.com"

  set :ssh_options, {
    keys: %w(/home/andrew/.ssh/capigit_rsa),
    forward_agent: false,
    auth_methods: %w(publickey password)
  }

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server "www.mydepot.com", user: "andrew", roles: %w{web app db}, ssh_options: fetch(:ssh_options)

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally

# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options




# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute :mkdir, '-p', release_path.join('tmp')
      info "create folder "+release_path.join('tmp').to_s
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc "reload the database with seed data"
  task :seed do
      execute "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end

  desc "copy secret files to project"
  task :copysec do
      execute "cp #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
         execute :rake, 'tmp:clear'
      end
    end
  end

end
