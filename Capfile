load 'deploy'
# Uncomment if you are using Rails' asset pipeline
    # load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks


namespace :deploy do
  desc "Symlinking"
  task :symlink_shared do
    run "ln -s #{shared_path}/config/*.yml  #{release_path}/config/"
  end
end


after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:create_symlink', 'deploy:assets:precompile'
