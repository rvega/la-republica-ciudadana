set :application, "Republica Ciudadana"

set :keep_releases, 10

# Git stuff
set :scm, :git 
set :branch, "development"
set :repository,  "https://github.com/rvega/la-republica-ciudadana"
set :scm_username, "rvega"

# Ssh stuff
role :web, "larepublicaciudadana.co"
role :app, "larepublicaciudadana.co"
role :db,  "larepublicaciudadana.co", :primary => true
set :user, "rvega"
set :use_sudo, false
default_run_options[:pty] = true

# Paths in server
set :deploy_to, "/home/rvega/webapps/test_repu"
set :default_environment, { 
  'PATH' => "#{deploy_to}/bin:$PATH",
  'GEM_HOME' => "#{deploy_to}/gems",
}

# Paths in git repo
set :subdir, "server"
before "deploy:assets:precompile", "deploy:checkout_subdir"
namespace :deploy do
  desc "Checkout subdirectory and delete all the other stuff"
  task :checkout_subdir do
    run "mv #{current_release}/#{subdir}/ #{deploy_to}/tmp" 
    run "rm -rf #{current_release}/*"
    run "mv #{deploy_to}/tmp/#{subdir}/* #{current_release}"
    run "rm -rf #{deploy_to}/tmp/#{subdir}"
  end
end

# Sensitive config files
set :config_path, "/home/rvega/webapps/test_repu/config_files"
after "deploy:checkout_subdir", "deploy:copy_config_files"
namespace :deploy do
  desc "Copy config files"
  task :copy_config_files do
    run "cp -f #{config_path}/database.yml #{current_release}/config" 
    run "cp -f #{config_path}/environments/production.rb #{current_release}/environments" 
  end
end

# Restart nginx after deploying
namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
end


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
