# config valid for current version and patch releases of Capistrano
# lock "~> 3.11.2"  コメントアウト

# set :application, "my_app_name" コメントアウト
# set :repo_url, "git@example.com:me/my_repo.git" コメントアウト

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

lock "3.9.0"

set :application, "withFriend" #自分のapp_nameに変更
set :repo_url, "git@example.com:me/my_repo.git" #自分のリポジトリURLに変更
set :deploy_to, '/var/www/withFriend' #自分のapp_nameに変更
set :keep_releases, 3

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.4.1'

set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :linked_dirs, %w{log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle}
set :linked_files, %w{config/secrets.yml}

set :bundle_jobs, 4

namespace :deploy do
  task :restart do
    on roles(:web, :app, :db) do |host|
      execute "source /etc/environment"
    end
    invoke 'unicorn:restart'
  end
  after :finishing, 'deploy:cleanup'
end
