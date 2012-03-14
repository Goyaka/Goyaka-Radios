set :application, "radios.goyaka.com"
set :repository, "git@bitbucket.org:goyaka/goyakaradios.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "radios.goyaka.com"                          # Your HTTP server, Apache/etc
set :deploy_via, :remote_cache # Does a git pull instead of git clone everytime. Much faster.
set :domain, "radios.goyaka.com"
set :deploy_to, "/srv/www/radios.goyaka.com/app"

server domain, :web, :app

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

set :user, "alagu" unless exists? :user 
set :use_sudo, false

# RVM Shit
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2-p290@default'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end