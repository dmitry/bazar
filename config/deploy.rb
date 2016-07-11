require 'capistrano-db-tasks'

lock '3.5.0'

set :application, 'dmitry'
set :repo_url, 'git@github.com:dmitry/bazar.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, '/home/dmitry/www/bazar'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, false

set :linked_files, fetch(:linked_files, []).push(
                   'config/database.yml',
                   'config/secrets.yml',
                   'db/production.sqlite3'
                 )

set :linked_dirs, fetch(:linked_dirs, []).
                  push(
                    'log',
                    'tmp',
                    'vendor/bundle',
                    'public/system'
                  )

# Default value for default_env is {}
set :default_env, {
                  path: "/usr/local/ruby/bin:/usr/local/node/bin:$PATH"
                }

# Default value for keep_releases is 5
set :keep_releases, 3
set :keep_assets, 2

set :bundle_flags, '--deployment'
set :bundle_jobs, 1

set :rvm_ruby_version, '2.2.3'

set :migration_role, :app
set :assets_roles, :app

# https://github.com/sgruhier/capistrano-db-tasks
set :assets_dir, 'public/system'
set :local_assets_dir, 'public/system'
set :disallow_pushing, true

# set :passenger_restart_with_touch, false
